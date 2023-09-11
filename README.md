# zsh-calc 
## a plugin that allows you to run math calcuations with no prefixes
### showcase
```sh 
$10 + 20
30
$10gigabyte / 100 megabyte
100
```
## installation
by default zsh-calc searchs for a calcution program from   
qalc calc and bc  
qalc has highlighting unit calculations and conversion, physical constants, symbolic calculations,etc  
calc has less features but is faster  
install whichever u like i recommend qalc 
```sh
 sudo pacman -S libqalculate
```
to install simply run `install.sh`    
to activate the plugin source it at the bottom of your .zshrc   
```sh 
...
source /usr/share/zsh/plugins/zsh-calc/zsh-calc.zsh
```
if you have qalc and calc installed auto detection will pick qalc  
if you want it to use calc instead set CALC_CMD to "echo \$BUFFER > /tmp/"$USER"calctemp; calc -f /tmp/"$USER"calctemp" in your .zshrc
```sh
#qalc
CALC_CMD="echo \$BUFFER > /tmp/"$USER"qalctemp;qalc -t -c -f /tmp/"$USER"qalctemp"
#calc
CALC_CMD="echo \$BUFFER > /tmp/"$USER"calctemp; calc -f /tmp/"$USER"calctemp"
#bc
CALC_CMD='echo $BUFFER | bc -l'
```
credits to this stackexchange post 
https://unix.stackexchange.com/questions/486326/do-math-operation-on-the-numbers-typed-into-command-line-without-call-bc/486339#486339
