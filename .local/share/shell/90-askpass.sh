if [ -n "$DISPLAY" ]; then
	if [ -x '/usr/lib/ssh/ssh-askpass' ]; then
		[ -z "$SUDO_ASKPASS" ] && export SUDO_ASKPASS="/usr/lib/ssh/ssh-askpass"
		alias sudo='sudo -A'
	fi
fi
