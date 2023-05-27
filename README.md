dotfiles
========

Open questions ?
----------------

 - Terminal: Setup alacritty or how to use st ?
 - Vundle: setup submodule ?
 - password: setup submodule ?
 - shell history: setup submodule ?
 - feature branches ?

Setup
-----

```
$ cd $HOME
$ # Clone read-only
$ TARGET="https://github.com/pimzero/dotfiles.git"
$ # Or r/w with ssh+git
$ TARGET="git@github.com:pimzero/dotfiles.git"
$ git init --separate-git-dir=.dotfiles
$ git remote add origin "$TARGET"
$ git pull
[...]
$ dotfiles checkout -b "$(hostname)-conf"
$ dotfiles merge aaa-feature bbb-feature ccc-feature
```

To update:

```
$ dotfiles fetch
$ dotfile merge aaa-feature bbb-feature ccc-feature
```

List features

```
$ dotfile branch --list '*-feature'
```

This config is used for archlinux boxes. The following packages are expected:

### Base

```
$ pacman -S base git vim gnupg openssh python grep
```

### Dev

```
$ pacman -S base git gvim gnupg openssh python base-devel strace gdb valgrind clang llvm llvm-libs inetutils
```

### Optional

```
chromium

x11-ssh-askpass
i3-wm i3status slock
xorg-xrandr xorg-xmodmap
redshift blueberry pasystray
scrot

wine
qemu qemu-arch-extra
util-linux procps-ng

bash-completion
lesspipe
rlwrap
bc units

rsync

mutt
tarsnap
```
