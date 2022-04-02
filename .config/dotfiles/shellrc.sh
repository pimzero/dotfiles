#!/bin/sh

# Bash exports SHELL=/bin/bash; however, it is not standard
unset -v SHELL
SHELL=$(readlink /proc/$$/exe 2>/dev/null || '')

# ### Custom scripts:
# All shells load "~/._shell/*.sh"
# /bin/bash will also load "~/._shell/*.bash"
for f in ~/.local/share/shell/*; do
	case "$f" in
		*.bash) [ `basename $SHELL` = "bash" ] && . $f;;
		*.sh) . $f;;
	esac
done
