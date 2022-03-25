" # .vimrc

" ## Plugins

" Don't try to stay compatible with vi.
" Should be the first line
set nocompatible

" Vundle needs also this:
filetype off

" We now set the runtime path to include Vundle and initialize:
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'gmarik/Vundle.vim'

	for file in split(glob('~/.vim/plugs/*.vim', '\n'))
		exec 'source' fnameescape(file)
	endfor
call vundle#end()

filetype plugin indent on
syntax enable

for file in split(glob('~/.vim/confs/*.vim', '\n'))
	exec 'source' fnameescape(file)
endfor
