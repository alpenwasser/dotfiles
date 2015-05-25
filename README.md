dotfiles
==========================

zshrc, bashrc, vimrc and so on and so forth...

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

![ZSH Prompt Charged](http://www.alpenwasser.net/images/2015-05-23--23-50-44--prompt.png)
![ZSH Prompt Discharging](http://www.alpenwasser.net/images/2015-05-23--23-51-40--discharging.png)


Midnight Commander
------------------

Adds colour scheme from ![Zoltan Puskas](https://github.com/zpuskas/linux/blob/master/home/.local/share/mc/skins/darkened.ini),
blog post can be found ![here](https://sinustrom.info/2014/03/23/midnight-commander-dark-color-scheme/).

Adds some Vim-like keybindings:
* `h`: Left (move to parent directory)
* `j`: Down (move down in file list)
* `k`: Up (move in file list)
* `l`: Right (open dir)
* `shift-h`: Toggle hidden files being displayed
* `shift-c`: copy selected files
* `shift-m`: move selected files
