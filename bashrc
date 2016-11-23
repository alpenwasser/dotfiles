#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -a --color=auto'
alias lla='ls -la --color=auto'

#PS1='[\u@\h \W]\$ '
#PS1='\n \[\e[1;37m\]┌─[\[\e[1;36m\] \d \[\e[1;31m\]\T \[\e[1;37m\]] \n\[\e[1;37m\] └─[ \[\e[1;34m\]@ \[\e[1;32m\]\w\[\e[1;37m\]]\[\e[1;35m\]---> \[\e[0;37m\]'
PS1="\n\[\e[1;37m\]┌─[\[\e[1;33m\] \s v\V\[\e[1;36m\] \d $(date +%Y) \[\e[1;31m\]\t \e[1;32m\]\w\[\e[1;37m\] ]\n\[\e[1;37m\]└─[\[\e[0;37m\] \u\e[1;34m\] @ \e[0;37m\]\h \[\e[1;37m\]]\[\e[1;35m\] ---> \[\e[0;37m\]\e[m"


source ~/host/bin/notes.sh
