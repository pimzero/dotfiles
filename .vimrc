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
	Plugin 'Valloric/YouCompleteMe'

	Plugin 'tomasr/molokai'
	let g:molokai_original = 1

	Plugin 'bling/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'

	Plugin 'skywind3000/asyncrun.vim'

	Plugin 'jpalardy/vim-slime'

	Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on


" ### YouCompleteMe
" (Autocompletion)
let g:ycm_complete_in_strings = 0
let g:ycm_confirm_extra_conf = 0
" ^ is bad, we should use g:ycm_extra_conf_globlist or something to
let g:ycm_global_ycm_extra_conf = '/home/pim/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_enable_diagnostic_signs = 0

" Complete options (disable preview scratch window, longest removed to always
" show menu)
" As they said here :
" https://github.com/Valloric/YouCompleteMe/issues/234
set completeopt=menu,menuone

" ### vim-airline
" (Better status line)
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
set laststatus=2

" ### vim-slime
" (Ocaml repl)
let g:slime_target = "vimterminal"

" ## Basics

" Syntax
syntax enable

" Encoding
let &termencoding = &encoding
set encoding=utf-8

" ## Appearance

" ### Theme and colors
set background=dark
if ($TERM =~ '256color')
	colorscheme molokai
else
	" Custom colors for when you use a bad terminal
	" Line number
	" Dark background and Ligh blue foreground
	hi LineNr ctermfg=6 ctermbg=9
	" Standard background and white bold foreground
	hi CursorLineNR ctermfg=white ctermbg=8
	" Highlight current line
	" Dark background
	hi CursorLine cterm=NONE ctermbg=9
	hi CursorLine cterm=NONE,underline
endif

" ### Trailing whitespaces and tabs
set list
set listchars=tab:\⇒\ 

" ### Lines

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

set cursorline

set number

set scrolloff=7
"set numberwidth=5
"Todo: watch 'cpoptions'

" ### Code logic
set showmatch

" No background, red foreground
hi MatchParen cterm=bold ctermbg=none ctermfg=1

" ## Informations

set title

function! Get_nice_path(path)
	let user_at_host = $USER . '@' . hostname() . '/'
	let homepath = substitute(a:path, '^' . $HOME, '/~', '')
	return substitute(homepath, '^/', user_at_host, '')
endfunction

set titlestring=%(%{Get_nice_path(expand('%:p'))}%)\ %M

" ## Editing

" ### Indentation
set tabstop=8
set softtabstop=8
set shiftwidth=8
set smarttab

" ### Formatting
"
" (should be in C specific file maybe)
" (from clang.llvm.org/docs/ClangFormat.html)
map <C-K> :pyf /usr/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format.py<cr>

function! ClangFormatFile()
	let previous_position = getpos('.')
	execute "normal ggVG\<c-k>"
	call setpos('.', previous_position)
endfunction

" No drag selection (i.e.: don't go in visual mode by draging):
noremap <LeftDrag> <LeftMouse>
noremap! <LeftDrag> <LeftMouse>

" No paste with middle click:
noremap <MiddleRelease> <LeftMouse>
noremap! <MiddleRelease> <LeftMouse>
lnoremap <MiddleRelease> <LeftMouse>
noremap <MiddleDrag> <LeftMouse>
noremap! <MiddleDrag> <LeftMouse>
lnoremap <MiddleDrag> <LeftMouse>

" ### Cursor

" Keep cursor position when vim is closed
if has("autocmd")
	au BufReadPost * 
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif

" ### Deletions

" Delete and backspace in normal mode:
nnoremap <BS> X
nnoremap <Del> x

" Correct Keybinds with st: (See
" https://wiki.archlinux.org/index.php/St#Backspace_not_working_properly )
" TODO: :fixdel ???
if ($TERM == "st-256color")
	nnoremap <C-h> X
	nnoremap <BS> <Del>
	inoremap <C-h> <BS>
	inoremap <BS> <Del>
endif

" Let deletion removes '\n':
set backspace=2

" ### Searching
set hlsearch    " Highlight search
set incsearch   " Incremental search
set ignorecase  " Ignore case because i'm too lazy to press shift

" ### Clipboard
"
" Use system-wide clipboard (need +xterm_clipboard)
if has('unnamedplus')
	set clipboard=unnamedplus
else
	set clipboard=unnamed
endif

" ### History
set history=8000
set undolevels=8000
set showcmd

" ## Projects:

" From llvm
" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

" Enable syntax highlighting for LLVM files. To use, copy
" utils/vim/llvm.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

" Enable syntax highlighting for reStructuredText files. To use, copy
" rest.vim (http://www.vim.org/scripts/script.php?script_id=973)
" to ~/.vim/syntax .
augroup filetype
 au! BufRead,BufNewFile *.rst     set filetype=rest
augroup END

"set conceallevel=2
hi Conceal ctermbg=NONE ctermfg=white

set foldlevelstart=99

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
"autocmd FileType ocaml terminal ++close rlwrap ocaml -no-version
"
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
" NOTE(pim): This command is really slow (~3s). let's hardocde it
"let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
"let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
let s:opam_available_tools = ["merlin"]
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

set completeopt+=menuone,noselect,noinsert
set omnifunc=merlin#Complete

let g:ycm_language_server =
  \ [
	  \   {
	  \     'name': 'ocaml',
  \     'cmdline': ['ocaml-language-server', '--stdio'],
  \     'filetypes': ['ocaml']
  \   },
  \ ]

