dotfiles
==========================

zshrc, bashrc, vimrc and so on and so forth...

gnome-terminal
--------------

My eyes are getting old, so solarized-light it is...
The color palette is default solarized, except for Palette Color 13
(which is used for directory entries). That has changed to `#2B9CA9`

zshrc
-----

Features:
* Multi-line  box arrangement. If you like  that sort of thing,  this might be
  for you.
* git branch  indicator, including indicator for unmerged  changes (still work
  in progress though)
* battery indicator
* Asynchronous  updating: The prompt  updates every  second, whether  you have
  entered a command or not. So the clock, battery status and git indicator are
  always up to date.

Demo of the ZSH prompt:
![ZSH Prompt Demo](http://www.alpenwasser.net/emoticons/alpenwasser-zsh-prompt.gif)

Still images:
![ZSH Prompt Charged](http://www.alpenwasser.net/images/2015-05-23--23-50-44--prompt.png)
![ZSH Prompt Discharging](http://www.alpenwasser.net/images/2015-05-23--23-51-40--discharging.png)

Midnight Commander
------------------

### Color Scheme

Adds dark colour scheme from [Zoltan Puskas](https://github.com/zpuskas/linux/blob/master/home/.local/share/mc/skins/darkened.ini),
blog post can be found [here](https://sinustrom.info/2014/03/23/midnight-commander-dark-color-scheme/).

Screenshot:
![Midnight Commander Dark Colour Scheme](http://www.alpenwasser.net/images/2015-05-25--18-25-59--mc-darkened.png)


### Vi Keybindings

Adds some Vim-like keybindings. In main file browsing mode:
* `h`: Left (move to parent directory)
* `j`: Down (move down in file list)
* `k`: Up (move in file list)
* `l`: Right (open dir)
* `shift-j`: Page Down
* `shift-k`: Page Up
* `shift-h`: Toggle hidden files being displayed
* `shift-c`: copy selected files
* `shift-m`: move selected files
* `shift-d`: delete selected files

In tree listing:
* `j`: Down
* `k`: Up
* `l`: Enter (open directory)
* `h`: Forget. Closes directory and removes it from tree; reopening the parent dir will make it appear again. Not absolutely optimal, but apparently there is no way to just close the subtree again.
