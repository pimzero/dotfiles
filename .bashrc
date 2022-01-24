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

# Import "~/.shellrc.sh"
source ~/.shellrc.sh
