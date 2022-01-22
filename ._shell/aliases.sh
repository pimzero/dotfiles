#!/bin/sh

# colors
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# grep typos (fingers too fast)
alias grpe=grep
alias gpre=grep

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'


# cd parent shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias screenshot="scrot '$HOME/Screenshots/%F_%T.png'"

alias suspend='systemctl suspend'
alias pm-suspend='suspend'

alias qemu-kvm='qemu-system-x86_64 -enable-kvm'
alias gdb='gdb -q'
alias ocaml='rlwrap ocaml'
alias checkpatch='~/Data/linux/scripts/checkpatch.pl'
alias gitlog="git --no-pager log --oneline --decorate"

# startx: Clean env
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

mbox() {
	local NAME=$1
	shift
	mutt -F"$HOME/.mailconfs/$NAME" $@
}

# https://news.ycombinator.com/item?id=11071754
dotfiles() {
	if [ "$1" = "tig" ]; then
		shift
		GIT_DIR=$HOME/.dotfiles/ tig $@
	else
		git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@
	fi
}

hist() {
	CSEARCHINDEX="$HOME/.shell_history/.csearchindex" csearch -h $@ | uniq | grep -a $@
}

noaslr() { setarch "$(uname -m)" -R "$@"; }
set_randomize_va_space() { sysctl -w kernel.randomize_va_space=$@; }
