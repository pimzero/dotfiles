" TODO: (should be in C specific file maybe)
" (from clang.llvm.org/docs/ClangFormat.html)
map <C-K> :pyf /usr/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format.py<cr>

function! ClangFormatFile()
	let previous_position = getpos('.')
	execute "normal ggVG\<c-k>"
	call setpos('.', previous_position)
endfunction
