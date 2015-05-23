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

# Add autocompletion for SSH hosts based on known hosts
zstyle -e \
    ':completion::*:hosts'\
    hosts \
    'reply=($(sed -e "/^#/d" -e "s/ .*\$//" -e \
    "s/,/ /g" /etc/ssh_known_hosts(N) \
    ~/.ssh/known_hosts(N) 2>/dev/null | \
    xargs) $(grep \^Host ~/.ssh/config(N) | \
    cut -f2 -d\  2>/dev/null | xargs))'

function git_prompt {
    # Check if dir is inside a git repo
    if [ $(git rev-parse --is-inside-work-tree 2>>/dev/null) ];then

        # Grab git branch
        ref=$(git symbolic-ref HEAD 2>>/dev/null | cut -d'/' -f3)

        # Check if uncommitted changes have been made on current branch.
        if [[ $(git status --porcelain -z) != '' ]];then
            ref="${ref} ${PR_RED}+${PR_WHITE}"
        fi

        # Don't put any funny symbols into TTY
        if [[ $TERM == linux ]];then
            echo "${PR_GREEN} |-' ${PR_NO_COLOUR}${PR_LIGHT_CYAN} $ref "
        else
            #echo "$PR_GREEN \ue0a0 $PR_CYAN $ref "

            # Note that this is not a standard UTF-8 symbol,
            # requires a patched powerline font.
            echo "${PR_GREEN}  ${PR_NO_COLOUR}${PR_LIGHT_CYAN} $ref "
        fi
    else
        echo ''
    fi
}

function battery_status {

    # ---------------------------------------------------- #
    # Checks battery status and  outputs result. NOTE: The #
    # path  to the  uevent file  for the  battery on  your #
    # laptop might need to be adjusted for this.           #
    #                                                      #
    # How  to  find your  battery,  one  of the  following #
    # commands should get you  started on the right track: #
    # find  /sys/devices  -type  d  -iname  \*BAT0\*       #
    # find /sys/devices -type f -iname \*power_supply\*    #
    # ---------------------------------------------------- #

    local battery_string=''
	local battery_path='/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:5f/PNP0C09:00/ACPI0001:00/ACPI0002:00/power_supply/BAT0/uevent'
	local utf_charging_symbol='⚇'
    local tty_charging_symbol='CHAR'
	local utf_discharging_symbol='⚡'
	local tty_discharging_symbol='BAT'
	local utf_charged_symbol='☻'
	local tty_charged_symbol='FULL'
    local charging_symbol=''
    local discharging_symbol=''
    local charged_symbol=''

    if [[ $TERM == 'linux' ]];then
        charging_symbol=$tty_charging_symbol
        discharging_symbol=$tty_discharging_symbol
        charged_symbol=$tty_charged_symbol
    else
        charging_symbol=$utf_charging_symbol
        discharging_symbol=$utf_discharging_symbol
        charged_symbol=$utf_charged_symbol
    fi

    local power_supply_status='' # can be 'Discharging', 'Full' or 'Charging'
    local power_supply_charge_full=''
    local power_supply_charge_now=''
    local power_supply_current_now=''
    local battery_percentage=''

    # No battery present
    # TODO: Take into account swappable batteries
    if [[ $battery_path == '' ]];then
        return
    fi

    # Grab status:
    power_supply_status="$(grep 'POWER_SUPPLY_STATUS=' < "$battery_path")" 
    power_supply_charge_full="$(grep 'POWER_SUPPLY_CHARGE_FULL=' < "$battery_path")" 
    power_supply_charge_now="$(grep 'POWER_SUPPLY_CHARGE_NOW=' < "$battery_path")" 

    # Cut off unnecessary string parts from front:
    power_supply_status="${power_supply_status#*=}"
    power_supply_charge_full="${power_supply_charge_full#*=}"
    power_supply_charge_now="${power_supply_charge_now#*=}"


    case "${power_supply_status}" in
        Full)
            battery_string=" ${PR_LIGHT_GREEN}${charged_symbol}"
            ;;
        Discharging)
            battery_string=" ${PR_LIGHT_RED}${discharging_symbol}"
            ;;
        Charging)
            battery_string=" ${PR_LIGHT_CYAN}${charging_symbol}"
            ;;
        *)
            return
            ;;
    esac

    # The numbers we get from  the uevent file are integers,
    # we must convert them to  floating point first lest ZSH
    # do integer math for the percentage calculations.
    power_supply_charge_now="${power_supply_charge_now}."
    power_supply_charge_full="${power_supply_charge_full}."
    ((battery_percentage = power_supply_charge_now / power_supply_charge_full * 100))
    battery_percentage=${battery_percentage%\.*}

    battery_string="${battery_string} ${battery_percentage}%%"

    echo "${battery_string}"
}


# prompt configuration
autoload colors; colors
function precmd {

    GIT_STRING="$(git_prompt)"

    BATTERY_STRING="$(battery_status)" 

    local TERMWIDTH
    #COLUMNS is env variable
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_FILLSPACE=""
    PR_PWDLEN=""
    PR_BOXTOP="" # box on top right
    PR_BOXBOT="" # box on bottom left
    PR_BOXPWD="" # box on top left
    
    # %n: login name, %m: part of host name to first -
    # %l: current tty, e.g. pts/100
    # %~: current working dir relative to user's home dir
    # figure out the length of this construct
    local promptsize=${#${(%):---( %D{%a %b %d %y}%n @ %m)---()--}}
    #local righttopboxsize=${#${(%):- ${BATTERY_STRING}%D{%a %b %d %y}%n @ %m}}
    local pwdsize=${#${(%):-%~}}
    local righttopboxsize=${#${(%):- %D{%a %b %d %y}%n @ %m}}
    local leftbotboxsize=${#${(%):- %* }}

    # Subtract to account for color strings
    if [[ "${#GIT_STRING}" != 0 ]];then

        # There is likely something  weird going on with the
        # color string lengths across various diferent $TERM
        # variables  (screen,  linux,  xterm,  xerm-256color
        # etc.).
        case "${TERM}" in
            linux)
                (( leftbotboxsize = leftbotboxsize - 3 ))
                ;;
            xterm*)
                (( leftbotboxsize = leftbotboxsize - 2 ))
                ;;
        esac


        ((leftbotboxsize = leftbotboxsize + ${#GIT_STRING} - 30))

        # Color in case of modified branch
        if [[ $(git status --porcelain -z) != '' ]];then
            (( leftbotboxsize = leftbotboxsize -26 ))
        fi
    fi

    if [[ "${#BATTERY_STRING}" != 0 ]];then
        # Subtract 9 for colors
        ((leftbotboxsize = ${leftbotboxsize} + ${#BATTERY_STRING} - 9))
        BATTERY_STRING="${BATTERY_STRING} "
    fi

    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
        PR_BOXPWD="\${(l.$PR_PWDLEN..${PR_HBAR}.)}"
        PR_BOXTOP="\${(l.(($righttopboxsize + 2))..${PR_HBAR}.)}"
        PR_BOXBOT="\${(l.$leftbotboxsize..${PR_HBAR}.)}"
        PR_FILLSPACE="   "
    else
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
        PR_FILLSPACE="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize) + 3))..${PR_SPACE}.)}"
        PR_BOXTOP="\${(l.(($righttopboxsize + 2))..${PR_HBAR}.)}"
        PR_BOXBOT="\${(l.$leftbotboxsize..${PR_HBAR}.)}"
        PR_BOXPWD="\${(l.$pwdsize..${PR_HBAR}.)}"
    fi


}


# Continuously update the prompt
TRAPALRM() {
    precmd
    zle reset-prompt
}
TMOUT=1

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
        eval PR_NORMAL_$color='%{$terminfo[normal]$fg[${(L)color}]%}'
        eval PR_LIGHT_$color='%{$terminfo[light]$fg[${(L)color}]%}'
        #eval PR_NORMAL_$color='%{$fg[${(L)color}]%}'
        #eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
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

    # Set box characters, based on whether we're in a TTY or not.
    if [[ $TERM == 'linux' ]];then
        PR_SHIFT_IN=''
        PR_SHIFT_OUT=''
        PR_HBAR='-'
        PR_ULCORNER='-'
        PR_LLCORNER='-'
        PR_LRCORNER='-'
        PR_URCORNER='-'
        PR_TLEFT='+'
        PR_TRIGHT='+'
        PR_VBAR='|'
        PR_SPACE=' '
    else
        PR_SHIFT_IN="%{$terminfo[smacs]%}"
        PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
        PR_HBAR=${altchar[q]:-}
        PR_ULCORNER='╭'
        PR_LLCORNER='╰'
        PR_LRCORNER='╯'
        PR_URCORNER='╮'
        PR_TLEFT=${altchar[u]:--}
        PR_TRIGHT=${altchar[t]:--}
        PR_VBAR=${altchar[x]:-|}
        PR_SPACE=' '
    fi

    # Set colors based on root or not
    # %(x.true.false)
    PR_BOX_COLOR=%(!.$PR_RED.$PR_MAGENTA)
    PR_LINE_COLOR=%(!.$PR_WHITE.$PR_CYAN)
    
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
    # Finally, the prompt.
    PROMPT='\
$PR_SET_CHARSET\
$PR_STITLE\
${(e)PR_TITLEBAR}\
$PR_BOX_COLOR\
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
$PR_LINE_COLOR\
$PR_SHIFT_IN\
$PR_ULCORNER\
$PR_BOX_COLOR\
$PR_HBAR\
$PR_TLEFT\
$PR_SHIFT_OUT\
$PR_NO_COLOUR\
$PR_NORMAL_GREEN\
%$PR_PWDLEN<...<%~%<<\
$PR_BOX_COLOR\
$PR_SHIFT_IN\
$PR_TRIGHT\
$PR_HBAR\
$PR_LINE_COLOR\
$PR_HBAR\
${(e)PR_FILLBAR}\
$PR_BOX_COLOR\
$PR_HBAR\
$PR_TLEFT\
$PR_SHIFT_OUT\
$PR_NO_COLOUR\
$PR_NORMAL_LINE_COLOR %D{%a %b %d %y}\
$PR_NORMAL_WHITE%(!. %n. %n)\
$PR_NORMAL_GREEN @ \
$PR_NORMAL_WHITE%m \
$PR_BOX_COLOR\
$PR_SHIFT_IN\
$PR_VBAR\
$PR_SHIFT_OUT
$PR_LINE_COLOR\
$PR_SHIFT_IN\
$PR_VBAR \
$PR_BOX_COLOR\
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
$PR_LINE_COLOR\
$PR_SHIFT_IN\
$PR_VBAR \
$PR_BOX_COLOR\
$PR_ULCORNER\
${(e)PR_BOXBOT}\
$PR_URCORNER\
$PR_SHIFT_OUT
$PR_LINE_COLOR\
$PR_SHIFT_IN\
$PR_LLCORNER\
$PR_BOX_COLOR\
$PR_HBAR\
$PR_LRCORNER\
$PR_SHIFT_OUT\
$PR_NO_COLOUR\
$PR_NORMAL_RED %* \
$GIT_STRING\
$BATTERY_STRING\
$PR_BOX_COLOR\
$PR_SHIFT_IN\
$PR_LLCORNER\
$PR_HBAR\
$PR_SHIFT_OUT\
$PR_GREEN %(?.OK.$PR_LIGHT_RED%?) \
$PR_NO_COLOUR\
$PR_SHIFT_OUT\
%(!.$PR_RED.$PR_WHITE)%# \
$PR_NO_COLOUR '


    PS2='\
$PR_BOX_COLOR  \
$PR_SHIFT_IN\
$PR_LLCORNER\
$PR_HBAR\
$PR_TLEFT\
$PR_SHIFT_OUT\
$PR_LIGHT_GREEN\
%_\
$PR_BOX_COLOR\
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
