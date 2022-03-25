# https://wiki.archlinux.org/title/XDG_Base_Directory
if [ -z "$PASSWORD_STORE_DIR" ]; then
	if [ -n "$XDG_DATA_HOME" ]; then
		PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
	else
		PASSWORD_STORE_DIR="$HOME/.local/share/pass"
	fi
	export PASSWORD_STORE_DIR
fi
