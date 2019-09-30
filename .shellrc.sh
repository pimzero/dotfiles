#
# Pimzero's shell config
# ======================
#
#
# Disclaimer:
# ----------
#
# Each times you use lines you don't understand, you kill a kitten.
# Do as you want, but I love kitten so please don't kill them, it would be
# nice :)
#
#
# Todo:
# -----
#
# - Full POSIX compliance and maximum portability
#
#
# Changelog:
# ---------
#(insert date : ":r !date")
# 
# Sun Jun 21 18:53:45 CEST 2015
#   - Starting versioning
#

# Global config:
# -------------

# ### User $PATH:

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


# ### History:

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options

#export HISTCONTROL=ignoreboth
#export HISTFILE=~/.histfile
# https://twitter.com/michaelhoffman/status/639178145673932800
HISTFILE="${HOME}/.shell_history/$(date -u +%Y-%m-%d_%H:%M:%S)_$(hostname -s)_$$"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

HISTSIZE=80000
HISTFILESIZE=160000

# ignore basic commands

#export HISTIGNORE='ls:cd:history'

# append to the history file, don't overwrite it

#if [[ `basename $SHELL` == "bash" ]]; then
#	shopt -s histappend
#fi
#if [[ `basename $SHELL` == "zsh" ]]; then
#	setopt appendhistory
#	setopt hist_ignore_all_dups
#	setopt hist_ignore_space
#fi

# ### Custom scripts:
# All shells load "~/.shell/*.sh"
# /bin/bash will also load "~/.shell/*.bash"

for f in ~/.shell/*.sh; do
	source $f;
done
if [[ `basename $SHELL` == "bash" ]]
then
	for f in ~/.shell/*.bash; do
		source $f;
	done
fi

# ### Environement varialbes:

export PAGER="less"
export VISUAL="vim"
export EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
#export NNTPSERVER="news.epita.fr"
#export SLSH_PATH_ENV=$SLSH_PATH_ENV:~/.slsh
#ANDROID_HOME="/opt/android-sdk"

eval $(gpg-agent --daemon --enable-ssh-support 2>/dev/null)
if [ -z "$SSH_AUTH_SOCK" ] ; then
	SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
	#SSH_AUTH_SOCK=/home/pim/.gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
fi
#eval "$(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)"

# TMP
function noaslr { setarch "$(uname -m)" -R "$@"; }
function set_randomize_va_space { sysctl -w kernel.randomize_va_space=$@; }
#function get_randomize_va_space {
#	sysctl -a 2>/dev/null |
#		grep "kernel.randomize_va_space" |
#		tr '=' '\t' |
#		sed 's/ //g' |
#		cut -f2
#}

# Piscine

function mkheader()
{
	for i in "$@"; do
		#gitmkfile "$i"
		touch "$i"
		EXERCISE=$(basename $(dirname $(readlink -f "$i")))
		CONTENT=$(cat "$i")
		GUARD=$(echo "$i" | sed 's/\.[^.]$//g' | tr 'a-z .-' 'A-Z___')
		echo "#ifndef $GUARD" > "$i"
		echo "# define $GUARD" >> "$i"
		echo "$CONTENT" >> "$i"
		echo "#endif /* !$GUARD */" >> "$i"
		#git add "$i"
		#git commit -m"${EXERCISE}: add header guards in $i"
	done
}

function mksourceandheader()
{
	for i in "$@"; do
		mkheader "${i}.h"
		touch "${i}.c"
		echo "#include \"${i}.h\"" > "${i}.c"
		#git add "${i}.c"
		#git commit -m"${EXERCISE}: include header in $i"
	done
}


function gitnewproject()
{
	touch TODO

	touch README

	echo "* marsai_p" > AUTHORS

	mkdir src
	mkdir tests
}

function upload_file() {
	gpg --output - --armor  --detach-sig "$1" | curl -X POST "http://ul.pimzero.com/file/$(basename $1)" -F "file=@$1" -F "signature=@-" && echo "ul.pimzero.com/f/$(basename $1)"
}

#cd "$BASEWD"

_mboxComplete() {
	local cur=${COMP_WORDS[COMP_CWORD]};
	COMPREPLY=( $(compgen -W "$(ls /home/pim/.mailconfs/)" -- $cur) );
}

complete -F _mboxComplete mbox
