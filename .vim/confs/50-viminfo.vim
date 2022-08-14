" https://wiki.archlinux.org/title/XDG_Base_Directory
if !has('nvim')
	if $XDG_STATE_HOME != ""
		set viminfofile=$XDG_STATE_HOME/vim/viminfo
	else
		set viminfofile=$HOME/.local/state/vim/viminfo
	endif
endif
