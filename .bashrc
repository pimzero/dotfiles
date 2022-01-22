# .bashrc
# -------
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Trace exports
# ```
# export() { builtin export "$@"; echo "${@%%=*} ${BASH_SOURCE[1]}:${BASH_LINENO[0]}"; }
# export() { read; builtin export "$@"; echo "${@%%=*} ${BASH_SOURCE[1]}:${BASH_LINENO[0]}"; } # single step
# complete() { builtin complete "$@"; echo "complete ${@%%=*} ${BASH_SOURCE[1]}:${BASH_LINENO[0]}"; }
# ```

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#shopt -s failglob

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
