#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

mkdir -p /dev/shm/firefox_pim

blueberry-tray &
redshift-gtk &
pasystray &
usbguard-applet-qt &

# Keyboard locale
xmodmap /home/pim/.Xmodmap
exec i3
