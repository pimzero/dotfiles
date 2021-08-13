_mboxComplete() {
	local cur=${COMP_WORDS[COMP_CWORD]};
	COMPREPLY=( $(compgen -W "$(ls /home/pim/.mailconfs/)" -- $cur) );
}

complete -F _mboxComplete mbox
