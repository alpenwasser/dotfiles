# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/of-1/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

# Lines configured by user

# Transparency
# This requires a running compositing manager such as xcompmgr or similar
# [ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null

# EDITOR environment variable
export EDITOR=vim

# FIM Image viewer
export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz

# autocomplete for aliases
setopt completealiases

# aliases
alias sudo='sudo '
alias ls='ls --color=auto --group-directories-first'
alias lsa='ls -a --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias lla='ls -lha --color=auto --group-directories-first'
alias ctree='tree -C'
alias pacs='pacman -Ss'
alias paci='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias pacrd='sudo pacman -Rd'
alias rmr='rm -r'
alias hddtemp='sudo hddtemp'
alias vpne='sudo vpnc ethz'
alias vpnd='sudo vpnc-disconnect'
alias ds='du -hs'
alias less='less -N'
alias grep='grep --color=auto'
alias update='sudo pacman -Syu'
alias vl='/usr/share/vim/vim74/macros/less.sh'
alias trm='transmission-remote'
alias kbch='setxkbmap -layout ch'
alias kbus='setxkbmap -layout us'

# sourcing custom scripts
source ~/host/bin/notes.sh
source ~/host/bin/filecount.sh
source ~/host/bin/cpf.sh
source ~/host/bin/man-color.sh
source ~/.zshrc.private
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# SSH Agent
#eval $(ssh-agent)
eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa id_rsa id_rsa_long)

# Functions
function git_prompt {
    # Check if dir is inside a git repo
    if [[ $(git rev-parse --is-inside-work-tree 2>>/dev/null) ]];then
        ref=$(git symbolic-ref HEAD 2>>/dev/null | cut -d'/' -f3)
        echo "$PR_GREEN:$PR_CYAN $ref "
    else
        echo ''
    fi
}

# prompt configuration
autoload colors; colors
function precmd {

    GIT_STRING="$(git_prompt)"

    local TERMWIDTH
    #COLUMNS is env variable
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_FILLSPACE=""
    PR_PWDLEN=""
    PR_BOXTOP=""
    PR_BOXBOT=""
    PR_BOXPWD=""
    
    # %n: login name, %m: part of host name to first -
    # %l: current tty, e.g. pts/100
    # %~: current working dir relative to user's home dir
    # figure out the length of this construct
    local promptsize=${#${(%):---( %D{%a %b %d %y}%n @ %m)---()--}}
    local pwdsize=${#${(%):-%~}}
    local lefttopboxsize=${#${(%):- %D{%a %b %d %y}%n @ %m}}
    local leftbotboxsize=${#${(%):- %* : %# }}
    # Subtract to account for color strings
    if ! [[ "${#GIT_STRING}" == 0 ]];then
        let "leftbotboxsize = ${leftbotboxsize} + ${#GIT_STRING} - 26 "
    fi

    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
        PR_BOXPWD="\${(l.$PR_PWDLEN..${PR_HBAR}.)}"
        PR_BOXTOP="\${(l.(($lefttopboxsize + 2))..${PR_HBAR}.)}"
        PR_BOXBOT="\${(l.$leftbotboxsize..${PR_HBAR}.)}"
        PR_FILLSPACE="   "
    else
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
        PR_FILLSPACE="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize) + 3))..${PR_SPACE}.)}"
        PR_BOXTOP="\${(l.(($lefttopboxsize + 2))..${PR_HBAR}.)}"
        PR_BOXBOT="\${(l.$leftbotboxsize..${PR_HBAR}.)}"
        PR_BOXPWD="\${(l.$pwdsize..${PR_HBAR}.)}"
    fi


    ###
    # Get APM info.

    if which ibam > /dev/null; then
	PR_APM_RESULT=`ibam --percentbattery`
    elif which apm > /dev/null; then
	PR_APM_RESULT=`apm`
    fi
}


setopt extended_glob

preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -n "\ek$CMD\e\\"
    fi
    echo -n "\n" # Needed so that we don't overwrite the lowest bar for the PS1 prompt.
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
        colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
        eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
        eval PR_NORMAL_$color='%{$fg[${(L)color}]%}'
        eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
        (( count = $count + 1 ))
    done

    # Get color reset ANSI sequence
    #PR_RESET=$terminfo[sgr0]
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    # Move cursor up one row
    PR_ONE_UP=$terminfo[cuu1]

    # Move cursor down one row
    PR_ONE_DOWN=$terminfo[cud1]

    # Clear to end of line
    PR_CLEAR_EL=$terminfo[el]

    ###
    # See if we can use extended characters to look nicer.
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}
    PR_TLEFT=${altchar[u]:--}
    PR_TRIGHT=${altchar[t]:--}
    PR_VBAR=${altchar[x]:-|}
    PR_SPACE=' '

    # round corners, experimental
    #PR_SHIFT_IN=''
    #PR_SHIFT_OUT=''
    #PR_HBAR='─'
    #PR_ULCORNER='╭'
    #PR_LLCORNER='╰'
    #PR_LRCORNER='╯'
    #PR_URCORNER='╮'
    #PR_TLEFT='┤'
    #PR_TRIGHT='├'
    #PR_VBAR='│'
    #PR_SPACE=' '
    
    ###
    # Decide if we need to set titlebar text.
    
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    
    
    ###
    # Decide whether to set a screen title
    #if [[ "$TERM" == "screen" ]]; then
	#PR_STITLE=$'%{\ekzsh\e\\%}'
    #else
	#PR_STITLE=''
    #fi
    
    
    ###
    # APM detection
    
    if which ibam > /dev/null; then
	PR_APM='$PR_RED${${PR_APM_RESULT[(f)1]}[(w)-2]}%%(${${PR_APM_RESULT[(f)3]}[(w)-1]})$PR_LIGHT_BLUE:'
    elif which apm > /dev/null; then
	PR_APM='$PR_RED${PR_APM_RESULT[(w)5,(w)6]/\% /%%}$PR_LIGHT_BLUE:'
    else
	PR_APM=''
    fi
   
    ###
    # Finally, the prompt.
    PROMPT='\
$PR_SET_CHARSET\
$PR_STITLE\
${(e)PR_TITLEBAR}\
$PR_MAGENTA\
$PR_SHIFT_IN  \
$PR_ULCORNER\
${(e)PR_BOXPWD}\
$PR_URCORNER\
$PR_SHIFT_OUT\
${(e)PR_FILLSPACE}\
$PR_SHIFT_IN\
$PR_ULCORNER\
${(e)PR_BOXTOP}\
$PR_URCORNER\
$PR_SHIFT_OUT
$PR_CYAN\
$PR_SHIFT_IN\
$PR_ULCORNER\
$PR_MAGENTA\
$PR_HBAR\
$PR_TLEFT\
$PR_SHIFT_OUT\
$PR_NO_COLOUR\
$PR_NORMAL_GREEN\
%$PR_PWDLEN<...<%~%<<\
$PR_MAGENTA\
$PR_SHIFT_IN\
$PR_TRIGHT\
$PR_HBAR\
$PR_CYAN\
$PR_HBAR\
${(e)PR_FILLBAR}\
$PR_MAGENTA\
$PR_HBAR\
$PR_TLEFT\
$PR_SHIFT_OUT\
$PR_NO_COLOUR\
$PR_NORMAL_CYAN %D{%a %b %d %y}\
$PR_NORMAL_WHITE%(!. %n. %n)\
$PR_NORMAL_GREEN @ \
$PR_NORMAL_WHITE%m \
$PR_MAGENTA\
$PR_SHIFT_IN\
$PR_VBAR\
$PR_SHIFT_OUT
$PR_CYAN\
$PR_SHIFT_IN\
$PR_VBAR \
$PR_MAGENTA\
$PR_LLCORNER\
${(e)PR_BOXPWD}\
$PR_LRCORNER\
$PR_SHIFT_OUT\
${(e)PR_FILLSPACE}\
$PR_SHIFT_IN\
$PR_LLCORNER\
${(e)PR_BOXTOP}\
$PR_LRCORNER\
$PR_SHIFT_OUT
$PR_CYAN\
$PR_SHIFT_IN\
$PR_VBAR \
$PR_MAGENTA\
$PR_ULCORNER\
${(e)PR_BOXBOT}\
$PR_URCORNER\
$PR_SHIFT_OUT
$PR_CYAN\
$PR_SHIFT_IN\
$PR_LLCORNER\
$PR_MAGENTA\
$PR_HBAR\
$PR_LRCORNER\
$PR_SHIFT_OUT\
$PR_NO_COLOUR\
$PR_NORMAL_RED %* \
$PR_LIGHT_GREEN: %(!.$PR_RED.$PR_WHITE)%# \
$GIT_STRING\
$PR_MAGENTA\
$PR_SHIFT_IN\
$PR_LLCORNER\
$PR_HBAR\
$PR_SHIFT_OUT\
$PR_GREEN %(?.OK.$PR_LIGHT_RED%?) \
$PR_NO_COLOUR\
$PR_SHIFT_OUT\
$PR_NO_COLOUR '


    PS2='\
$PR_MAGENTA  \
$PR_SHIFT_IN\
$PR_LLCORNER\
$PR_HBAR\
$PR_TLEFT\
$PR_SHIFT_OUT\
$PR_LIGHT_GREEN\
%_\
$PR_MAGENTA\
$PR_SHIFT_IN\
$PR_TRIGHT\
$PR_HBAR\
$PR_HBAR\
$PR_SHIFT_OUT\
$PR_NO_COLOUR '


    #PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
#$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
#$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
#$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

setprompt
# End of lines configured by user

PATH="/home/of-1/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/of-1/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/of-1/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/of-1/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/of-1/perl5"; export PERL_MM_OPT;
