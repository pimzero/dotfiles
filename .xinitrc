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
#setxkbmap fr
xmodmap /home/pim/.Xmodmap
#xrandr --output HDMI1 --auto --output VGA1 --auto --left-of HDMI1
#xrandr --output HDMI1 --auto --output VGA1 --auto --rotate right --right-of HDMI1 --scale 2x2 --output eDP1 --off
#xrandr --output HDMI1 --scale 0.5x0.5 --auto --output VGA1 --auto --rotate right --right-of HDMI1 --output eDP1 --off
xrandr --outpit HDMI1 --dpi 220
exec i3

# exec startxfce4
# ...or the Window Manager of your choice
#exec openbox-session

# Start vlc in background
#~/.scripts/vlc_bg.sh

# Deactivate touchpad
#synclient TouchpadOff=1

# We put our local shortcuts in the PATH
#export PATH=~/.local/bin:$PATH
