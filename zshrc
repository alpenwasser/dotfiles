# ---------------------------------------------------------------------------- #
# Autocompletion                                                               #
# ---------------------------------------------------------------------------- #

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/of-1/.zshrc'

# Add autocompletion for SSH hosts based on known hosts -------------- #
zstyle -e \
    ':completion::*:hosts'\
    hosts \
    'reply=($(sed -e "/^#/d" -e "s/ .*\$//" -e \
    "s/,/ /g" /etc/ssh_known_hosts(N) \
    ~/.ssh/known_hosts(N) 2>/dev/null | \
    xargs) $(grep \^Host ~/.ssh/config(N) | \
    cut -f2 -d\  2>/dev/null | xargs))'


# ---------------------------------------------------------------------------- #
# Load Modules                                                                 #
# ---------------------------------------------------------------------------- #
 
autoload -Uz compinit
autoload colors; colors
compinit

# ---------------------------------------------------------------------------- #
# Set Options                                                                  #
# ---------------------------------------------------------------------------- #
setopt prompt_subst
setopt autocd extendedglob nomatch
# Autocomplete for Aliases ------------------------------------------ #
setopt completealiases
setopt extended_glob

# ---------------------------------------------------------------------------- #
# History                                                                      #
# ---------------------------------------------------------------------------- #
HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=100000
setopt APPEND_HISTORY

# ---------------------------------------------------------------------------- #
# Other Stuff                                                                  #
# ---------------------------------------------------------------------------- #

unsetopt beep notify
bindkey -v # Vim Keybindings
TMOUT=5 # Timeout for continuously updating the prompt
export EDITOR=vim
[[ $TERM == 'screen' ]] && export TERM='screen-256color'


# ---------------------------------------------------------------------------- #
# Aliases                                                                      #
# ---------------------------------------------------------------------------- #
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
alias ds='du -hs'
alias less='less -N'
alias grep='grep --color=auto'
alias vl='/usr/share/vim/vim80/macros/less.sh'
alias trm='transmission-remote'
alias kbch='setxkbmap -layout ch'
alias kbus='setxkbmap -layout us'
alias kbX='xmodmap ~/.Xmodmap'
alias p2='pbzip2'
alias dt='date +%Y-%m-%d--%H-%M-%S'
alias gv='gvim'


# ---------------------------------------------------------------------------- #
# Source Custom Scripts                                                        #
# ---------------------------------------------------------------------------- #
source ~/host/bin/notes.sh
source ~/host/bin/man-color.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# ---------------------------------------------------------------------------- #
# Load SSH Keys                                                                #
# ---------------------------------------------------------------------------- #
#eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa id_rsa id_rsa_long)
eval $(keychain --eval --agents ssh -Q --quiet id_rsa_long)


# ---------------------------------------------------------------------------- #
# Prompt Configuration                                                         #
# ---------------------------------------------------------------------------- #

TRAPALRM() {
    precmd

    # ------------------------------------------------------------ #
    # This function makes the prompt update/refresh continuously.  #
    # ------------------------------------------------------------ #
    zle reset-prompt
}

function precmd {
    (( TERMWIDTH = ${COLUMNS} - 1 ))
}

preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -n "\ek$CMD\e\\"
    fi
    echo -n "\n" # Needed so that we don't overwrite the lowest bar for the PS1 prompt.
}

setprompt () {
    PROMPT="
$fg[cyan]%n$reset_color @ $fg[cyan]%M$reset_color on %y in $fg[yellow]%~$reset_color --- %D{%Y-%m-%f %K:%M:%S}
%? %h %# "

    RPROMPT='[%F{yellow}%?%f]'

    PS2='asdf'
}

setprompt
