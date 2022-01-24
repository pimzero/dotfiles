function! CheckCols()
	highlight LongLine ctermbg=DarkRed guibg=Red
	au BufWinEnter * let w:m0=matchadd('LongLine', '\%>' . &textwidth . 'v.\+', -1)
endfunction CheckCols

augroup colslimit
	au!
	autocmd FileType c,cpp  set textwidth=80
	autocmd FileType java   set textwidth=100
	autocmd FileType c,cpp,java  call CheckCols()
augroup END
