#!/bin/sh

# Bash exports SHELL=/bin/bash; however, it is not standard
unset -v SHELL
SHELL=$(readlink /proc/$$/exe 2>/dev/null || '')

is_in_path() {
	remove_slash() { echo ${1%/}; };
	local IFS=:;
	for i in $PATH; do
		if [ $(remove_slash "$1") = "$i" ]; then
			return 1;
		fi;
	done;
}

# #### Locally installed binaries
#export PATH=~/.local/bin:$PATH

# #### Calbal (Haskell) installed binaries
#export PATH=~/.cabal/bin/:$PATH

# #### Gem (Ruby) installed binaries
#export PATH=~/.gem/ruby/2.4.0/bin:$PATH

# ### Go installed binaries
is_in_path ~/go/bin
[ $? -eq 0 ] && export PATH=~/go/bin:$PATH

# ### .local/bin
is_in_path ~/.local/bin
[ $? -eq 0 ] && export PATH=~/.local/bin:$PATH


# ### History:

# https://twitter.com/michaelhoffman/status/639178145673932800
#HISTFILE="${HOME}/.shell_history/$(date -u +%Y-%m-%d_%H:%M:%S)_$(hostname -s)_$$.hist"
HISTFILE="${HOME}/.shell_history/$(date -u +%Y-%m-%d_%H:%M:%S)_$(hostname)_$$.hist"

HISTSIZE=80000
HISTFILESIZE=160000

# ### Custom scripts:
# All shells load "~/.shell/*.sh"
# /bin/bash will also load "~/.shell/*.bash"

for f in ~/.shell/*.sh; do
	. $f;
done
if [ `basename $SHELL` = "bash" ]; then
	for f in ~/.shell/*.bash; do
		. $f;
	done
fi

# ### Environement varialbes:

export PAGER="less"
export VISUAL="vim"
export EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
#export BROWSER="google-chrome-unstable"
export BROWSER="chromium"

if [ -n "$DISPLAY" ]; then
	export SUDO_ASKPASS="/usr/lib/ssh/ssh-askpass"
	alias sudo='sudo -A'
fi

eval $(gpg-agent --daemon --enable-ssh-support 2>/dev/null)
if [ -z "$SSH_AUTH_SOCK" ] ; then
	SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
	#SSH_AUTH_SOCK=/home/pim/.gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
fi
#eval "$(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)"

# TMP
noaslr() { setarch "$(uname -m)" -R "$@"; }
set_randomize_va_space() { sysctl -w kernel.randomize_va_space=$@; }

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias grpe=grep
alias gpre=grep
