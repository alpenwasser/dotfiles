# -------------------------------------------------------------------------- #
#                                             $HOME/.config/fish/fish.config #
# -------------------------------------------------------------------------- #
# DATE:       2017-DEC-12
# LINE WIDTH: 78 Max, if in any way possible

# -------------------------------------------------------------------------- #
#                                                             Vi Keybindings #
# -------------------------------------------------------------------------- #
fish_vi_key_bindings

# -------------------------------------------------------------------------- #
#                                                            Enable Autojump #
# -------------------------------------------------------------------------- #
# https://github.com/wting/autojump
# https://codeyarns.com/2014/02/27/how-to-install-autojump-for-fish/

if test -f /home/of-1/.autojump/share/autojump/autojump.fish;
    source /home/of-1/.autojump/share/autojump/autojump.fish;
end

# -------------------------------------------------------------------------- #
#                                                   Disable Greeting Message #
# -------------------------------------------------------------------------- #
# https://stackoverflow.com/questions/13995857/

set fish_greeting ""

# -------------------------------------------------------------------------- #
#                                                                   SSH KEYS #
# -------------------------------------------------------------------------- #
# https://superuser.com/questions/84615/how-do-you-source-a-file-in-fish
# https://bbs.archlinux.org/viewtopic.php?id=206366
set -gx HOSTNAME (hostname)
if status --is-interactive;
    eval (keychain --eval --agents ssh -Q --quiet id_rsa_long --nogui)
    [ -e $HOME/.keychain/$HOSTNAME-fish ]
    and . $HOME/.keychain/$HOSTNAME-fish
end

# -------------------------------------------------------------------------- #
#                                                                    Aliases #
# -------------------------------------------------------------------------- #
# https://fishshell.com/docs/current/commands.html#alias

#                                                                         ls #
alias ls=' ls --color=auto --group-directories-first'
alias lsa='ls --color=auto --group-directories-first -a'
alias ll=' ls --color=auto --group-directories-first -lh'
alias lla='ls --color=auto --group-directories-first -lha'

#                                                                     pacman #
# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks
alias pacs='      pacman -Ss'   # search for package
alias paci=' sudo pacman -S'    # install package
alias pacrd='sudo pacman -Rd'   # remove package, keep dependencies
alias pacr=' sudo pacman -Rns'  # remove package, don't create .pacsave files,
                                # remove unneeded dependencies implicitly
                                # installed
alias paco='pacman -Qdt'        # list all orphans
                                # NOTE: pacman -Rns $(pacman -Qtdq)
                                # recursively removes orphans and their
                                # configuration files. -Qt only lists true
                                # orphans. -Qtt also lists optional
                                # dependencies of installed packages.
alias pkgs='pkgbuilder -s'      # search for package in AUR
alias pkgi='pkgbuilder -S'      # install package from AUR

#                                                           Keyboard Layouts #
alias kbch='setxkbmap -layout ch'
alias kbus='setxkbmap -layout us'
alias kbX='xmodmap ~/.Xmodmap'

#                                                            general aliases #
alias less='less -N'
alias grep='grep --color=auto'
alias rmr='rm -r'

# -------------------------------------------------------------------------- #
#                                                                  Functions #
# -------------------------------------------------------------------------- #

#                                         Convenient pdf viewing with evince #
function ev
    evince "$argv" &
end
complete -c ev -x -a "(find . -maxdepth 2 -iname '*pdf' -printf '%P\n')"
#complete -c ev -x -a "(__fish_complete_suffix .pdf)"

#                                                                Keybindings #
# https://superuser.com/questions/409594/
# /usr/share/fish/functions/fish_vi_key_bindings.fish, line 132
function fish_user_key_bindings
    bind -M insert \cf 'accept-autosuggestion' 2>&1
end
