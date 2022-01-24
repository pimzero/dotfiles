set background=dark
colorscheme molokai

set list
set listchars=tab:\⇒\ 

" From llvm
highlight WhitespaceEOL ctermbg=DarkRed guibg=Red
if v:version >= 702
	" Whitespace at the end of a line. This little dance suppresses
	" whitespace that has just been typed.
	au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
	au InsertEnter * call matchdelete(w:m1)
	au InsertEnter * let w:m2=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
	au InsertLeave * call matchdelete(w:m2)
	au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
else
	au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
	au InsertLeave * syntax match WhitespaceEOL /\s\+$/
endif

set cursorline
set number
set scrolloff=7

" Keep cursor position when vim is closed
if has("autocmd")
	au BufReadPost * 
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif

" Delete and backspace in normal mode:
nnoremap <BS> X
nnoremap <Del> x

" Let deletion removes '\n':
set backspace=2

" Search
set hlsearch    " Highlight search
set incsearch   " Incremental search
set ignorecase  " Ignore case because i'm too lazy to press shift

" Use system-wide clipboard (need +xterm_clipboard)
if has('unnamedplus')
	set clipboard=unnamedplus
else
	set clipboard=unnamed
endif

" Encoding
let &termencoding = &encoding
set encoding=utf-8
