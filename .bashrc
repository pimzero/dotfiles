# .bashrc
# -------
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Trace exports
# export() { builtin export "$@"; echo "${@%%=*} ${BASH_SOURCE[1]}:${BASH_LINENO[0]}"; }

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1="\[$(tput bold)\]"
	PS1=$PS1"\[$(tput setaf 1)\]\u"
	PS1=$PS1"\[$(tput setaf 7)\]@"
	PS1=$PS1"\[$(tput setaf 4)\]\H"
	#PS1=$PS1"\[$(tput bold)\]:"
	PS1=$PS1"\[$(tput setaf 7)\]:"
	PS1=$PS1"\[$(tput setaf 6)\]\w"
	PS1=$PS1"\[$(tput setaf 7)\]\\$"
	PS1=$PS1"\[$(tput sgr0)\] "
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

PROMPT_COMMAND='history -a'

# Import "~/.shellrc.sh"
source ~/.shellrc.sh

export NNTPSERVER=news.epita.fr

#PATH="/home/pim/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/pim/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/pim/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
export PERL5LIB="/home/pim/perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="/home/pim/perl5"
PERL_MB_OPT="--install_base \"/home/pim/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/pim/perl5"; export PERL_MM_OPT;
