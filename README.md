Arch Linux Install Scripts
==========================

These are various Installation scripts for  Arch Linux (or at least there will
be various ones once I've progressed a bit further). I have tried to keep them
as simple as I can while  still getting the functionality I desire. This means
that they are not hugely complex beasts,  but mostly just a sequence of simple
commands  which  would  normally  be  entered during  an  install,  with  some
additional configuration and customisations thrown in.

The scripts are rather tightly tailored  to my own personal needs, however due
to their  rather simple nature  they should be fairly  easy to adapt  to other
people's requirements if so desired.


USAGE
-----

The  simplest  way  is  to  grab  the  git  repo  once  you  have  booted  the
Arch  install  medium. Note that  git  is  not  by  default installed  on  the
Arch  install medium.   You  can either  install it  after  having booted  the
install (note  that in  that case  the install will  not be  persistent across
reboots), or  you can embed  it into your own  custom Arch install  medium via
[archiso](https://wiki.archlinux.org/index.php/Archiso).

For installing git during the install, you'll need to sync the repos and then
install it like usual:

> `pacman -Sy`

> `pacman -S git`

After that, clone the repository:

> `git clone https://github.com/alpenwasser/archinst.git`

Change into the desired directory and run the respective install script, for
example:

> `cd archinst/QEMU`

> `./qemu.sh`


QEMU
----

Sets up a minimal QEMU virtual machine without X. As the script suite is still
in very early development, this is the  only version so far. Will also be used
as  a testbed  before changes  are  rolled out  into other  scripts once  I've
created those.
