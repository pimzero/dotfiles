#!/bin/sh

# colors
if [ -x /usr/bin/dircolors ]; then
    # TODO: Removed at the moment as its 1341 bytes in env
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'

alias screenshot="scrot '$HOME/Screenshots/%F_%T.png'"

function mbox()
{
	local NAME=$1
	shift
	mutt -F"/home/pim/.mailconfs/$NAME" $@
}

alias suspend='systemctl suspend'
alias pm-suspend='suspend'

alias qemu-kvm='qemu-system-x86_64 -enable-kvm'
alias gdb='gdb -q'
alias ocaml='rlwrap ocaml'
alias checkpatch='~/Data/linux/scripts/checkpatch.pl'
alias gitlog="git --no-pager log --oneline --decorate"

alias startx='exec env -i \
	DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
	HOME="$HOME" \
	INVOCATION_ID="$INVOCATION_ID" \
	JOURNAL_STREAM="$JOURNAL_STREAM" \
	PATH="$PATH" \
	SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
	USER="$USER" \
	XAUTHORITY="$XAUTHORITY" \
	XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
	XDG_SEAT="$XDG_SEAT" \
	XDG_SESSION_CLASS="$XDG_SESSION_CLASS" \
	XDG_SESSION_ID="$XDG_SESSION_ID" \
	XDG_SESSION_TYPE="$XDG_SESSION_TYPE" \
	XDG_VTNR="$XDG_VTNR" \
	startx'

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
