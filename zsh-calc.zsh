if [[ -z $CALC_CMD ]]; then
for cmd in qalc calc bc;do
   command -v $cmd >/dev/null 2>&1 ||
   continue 
   #copying CALC_CMD to your .zshrc would decrease startup time if that's even a problem
   #and also allow you to change command line arguments
   case "$cmd" in
      "qalc") CALC_CMD="echo \$BUFFER > /tmp/"$USER"qalctemp; qalc -t -c -f /tmp/"$USER"qalctemp"
      ;;
      "calc") CALC_CMD="echo \$BUFFER > /tmp/"$USER"calctemp; calc -f /tmp/"$USER"calctemp"
      ;;
      "bc") CALC_CMD="echo \$BUFFER' | bc -l"
      ;;
   esac
   break 
done
fi

if [[ -z $CALC_CMD ]]; then
   echo "zsh-calc Failed to find a calculation program (qalc,calc,bc)"
   return
fi

#helper function for setting qalc's base
function base() {
   echo "base $@" | qalc > /dev/null 
}

lastcommand=""
function accept-line() {
   if [[ $BUFFER =~ '^[ ]*[-+\(0-9]' ]]; then
       print -S -- "$BUFFER" #saving the command to history
       CONTENT=$(eval $CALC_CMD)
       printf "\n${CONTENT%$'\n'}"
       lastcommand="${BUFFER/ */}"
       if [[ $BUFFER =~ "^[^ ()]+[(]" ]]; then
           lastcommand="${BUFFER/[ (]+[)] */}"
       fi
      # alias the last command to avoid command not found error
      function $lastcommand() {
         return 0
      }
      calcuated='1'
   else 
      unset calcuated
   fi
   zle .$WIDGET
}

calc_preexec(){
   if ! [[ -z $calcuated ]]; then
      setopt SH_GLOB
   fi
}

[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions calc_preexec)


calc_precmd(){
   if ! [[ -z $calcuated ]]; then
      setopt NO_SH_GLOB
      unset -f $lastcommand
   fi
}

[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions calc_precmd)

zle -N accept-line
