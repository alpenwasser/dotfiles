# -------------------------------------------------------- #
# By default, don't do anything dangerous                  #
# -------------------------------------------------------- #
.DEFAULT_GOAL := sync

# -------------------------------------------------------- #
# Copy configuration  of current machine into  the dotfile #
# repository. This is the default target so that we do not #
# accidentally overwrite the machine's config or something #
# silly like that.                                         #
# -------------------------------------------------------- #
sync:
	mkdir -p config/mc
	mkdir -p local/share/mc/skins
	mkdir -p vim
	mkdir -p i3
	cp ~/.config/mc/ini config/mc/
	cp ~/.config/mc/mc.keymap config/mc/
	cp ~/.local/share/mc/skins/darkened.ini local/share/mc/skins/
	cp ~/.i3/* ./i3
	cp ~/.bashrc bashrc
	cp ~/.tmux.conf tmux.conf
	cp -r ~/.vim/colors vim/
	cp -r ~/.vim/plugin vim/
	cp ~/.vimrc vimrc
	cp ~/.xinitrc xinitrc
	cp ~/.Xmodmap Xmodmap
	cp ~/.Xresources Xresources
	cp ~/.zshrc zshrc
	#cp ~/.penta.txt penta.txt
	#cp ~/.pentadactylrc pentadactylrc
	#cp ~/.pentadactyl -r pentadactyl/

# -------------------------------------------------------- #
# Install Everything, Everywhere.                          #
# Overwrites  any existing  configuration which  currently #
# resides on the machine.                                  #
# -------------------------------------------------------- #
install:
	mkdir -p ~/.config/mc
	mkdir -p ~/.local/share/mc
	mkdir -p ~/.i3
	mkdir -p ~/.vim
	cp -r config/mc/* ~/.config/mc
	cp -r local/share/mc/* ~/.local/share/mc
	cp -r i3/* ~/.i3
	cp -r vim/* ~/.vim
	cp  bashrc ~/.bashrc
	cp  tmux.conf ~/.tmux.conf
	cp  vimrc ~/.vimrc
	cp  xinitrc ~/.xinitrc
	cp  Xmodmap ~/.Xmodmap
	cp  Xresources ~/.Xresources
	cp  zshrc ~/.zshrc
	#cp penta.txt ~/.penta.txt
	#cp pentadactylrc ~/.pentadactylrc
	#cp -r pentadactyl/ ~/.pentadactyl

# -------------------------------------------------------- #
# Target for Vim                                           #
# -------------------------------------------------------- #
tvim:
	mkdir -p ~/.vim
	cp -r vim/* ~/.vim
	cp vimrc ~/.vimrc
