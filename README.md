# Zsh-calc 
A plugin that allows you to run math calcuations without a prefix.
## Showcase
``` ada
$ 10 + 20
30
$ 10 gigabyte / 100 megabyte
100
```
## Installation
zsh-calc relies on an external calculation program.   
By default it supports:
qalc which has highlighting unit calculations and conversion, physical constants, symbolic calculations, etc;   
calc, and bc.
You can also configure other calculation programs see [configuring](https://github.com/Sam-programs/zsh-calc#configuring).
I recommend qalc.   
```sh
#arch linux
sudo pacman -S libqalculate
# for other distros, search with your package manager for qalculate or qalc
```
To install the plugin itself, run the `install.sh`.    
To activate the plugin, source it at the bottom of your `.zshrc`.
```sh 
...
source /usr/share/zsh/plugins/zsh-calc/zsh-calc.zsh
```
## Configuring
The auto detection system will pick the calculation program in this order:  
1. qalc  
2. calc  
3. bc  

To explicitly use a program, set `CALC_CMD` to one of the values below
```sh
#qalc
CALC_CMD="echo \$BUFFER > /tmp/"$USER"qalctemp; qalc -t -c -f /tmp/"$USER"qalctemp"
#calc
CALC_CMD="echo \$BUFFER > /tmp/"$USER"calctemp; calc -f /tmp/"$USER"calctemp"
#bc
CALC_CMD='echo \$BUFFER | bc -l'
# custom
# BUFFER is your command line
CALC_CMD='echo \$BUFFER | CUSTOM_CALC'
```
## Highlighting
If you are using [zsh-sytnax-highlight](https://github.com/zsh-users/zsh-syntax-highlighting), you can add this regex-highlight to highlight digits:
```sh
typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=('[0-9]' fg=cyan)
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main regexp)
```
# Credits
[unix stackexchange post](https://unix.stackexchange.com/questions/486326/do-math-operation-on-the-numbers-typed-into-command-line-without-call-bc/486339#486339)
