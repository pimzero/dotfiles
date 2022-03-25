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
if [ `basename $SHELL` = "bash" ]; then
	PS1="\[$($tput_cmd bold)\]"
	PS1=$PS1"\[$($tput_cmd setaf 1)\]\u"
	PS1=$PS1"\[$($tput_cmd setaf 7)\]@"
	PS1=$PS1"\[$($tput_cmd setaf 4)\]\H"
	PS1=$PS1"\[$($tput_cmd setaf 7)\]:"
	PS1=$PS1"\[$($tput_cmd setaf 6)\]\w"
	PS1=$PS1"\[$($tput_cmd setaf 7)\]\\$"
	PS1=$PS1"\[$($tput_cmd sgr0)\] "
else
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
	PS1=$PS1"$($tput_cmd sgr0) "
fi

unset color_prompt tput_cmd
