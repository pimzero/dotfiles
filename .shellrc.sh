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
HISTFILE="${HOME}/.shell_history/$(date -u +%Y-%m-%d_%H:%M:%S)_$(hostname)_$$.hist"

HISTSIZE=80000
HISTFILESIZE=160000

# ### PS1

if [ -x /usr/bin/tput ] && tput setaf 1 >/dev/null 2>&1; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
fi

if [ "$color_prompt" = yes ]; then
	tput_cmd=tput
else
	tput_cmd=:
fi

# PS1='\u@\H:\w\\$ ' # Bash format is not supported by dash
PS1="$($tput_cmd bold)"
PS1=$PS1"$($tput_cmd setaf 1)"'$USER'
PS1=$PS1"$($tput_cmd setaf 7)@"
PS1=$PS1"$($tput_cmd setaf 4)$(hostname)"
PS1=$PS1"$($tput_cmd setaf 7):"
PS1=$PS1"$($tput_cmd setaf 6)"
PS1=$PS1'$(
		if [ "${PWD#$HOME}" = "$PWD" ]; then
			t="$PWD";
		else
			t="~${PWD#$HOME}";
		fi;
		[ "$t" != "/" ] && t="${t%/}";
		printf "$t"
	)'
PS1=$PS1"$($tput_cmd setaf 7)$([ "$USER" = 'root' ] && printf '#' || printf '$')"
PS1=$PS1"$($tput_cmd sgr0)$($tput_cmd el) "

unset color_prompt tput_cmd

# ### Custom scripts:
# All shells load "~/._shell/*.sh"
# /bin/bash will also load "~/._shell/*.bash"

for f in ~/._shell/*.sh; do
	. $f;
done
if [ `basename $SHELL` = "bash" ]; then
	for f in ~/._shell/*.bash; do
		. $f;
	done
fi

# ### Environement varialbes:

export PAGER="less"
export VISUAL="vim"
export EDITOR="vim"
export BROWSER="chromium"

if [ -n "$DISPLAY" ]; then
	export SUDO_ASKPASS="/usr/lib/ssh/ssh-askpass"
	alias sudo='sudo -A'
fi

eval $(gpg-agent --daemon --enable-ssh-support 2>/dev/null)
if [ -z "$SSH_AUTH_SOCK" ] ; then
	SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"; export SSH_AUTH_SOCK;
fi
