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

# https://twitter.com/michaelhoffman/status/639178145673932800
HISTFILE="${HOME}/.shell_history/$(date -u +%Y-%m-%d_%H:%M:%S)_$(hostname -s)_$$"

HISTSIZE=80000
HISTFILESIZE=160000

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

eval $(gpg-agent --daemon --enable-ssh-support 2>/dev/null)
if [ -z "$SSH_AUTH_SOCK" ] ; then
	SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
	#SSH_AUTH_SOCK=/home/pim/.gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
fi
#eval "$(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)"

# TMP
function noaslr { setarch "$(uname -m)" -R "$@"; }
function set_randomize_va_space { sysctl -w kernel.randomize_va_space=$@; }

_mboxComplete() {
	local cur=${COMP_WORDS[COMP_CWORD]};
	COMPREPLY=( $(compgen -W "$(ls /home/pim/.mailconfs/)" -- $cur) );
}

complete -F _mboxComplete mbox
