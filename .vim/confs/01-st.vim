" Correct Keybinds with st: (See
" https://wiki.archlinux.org/index.php/St#Backspace_not_working_properly )
" TODO: :fixdel ???
if ($TERM == "st-256color")
	nnoremap <C-h> X
	nnoremap <BS> <Del>
	inoremap <C-h> <BS>
	inoremap <BS> <Del>
endif

