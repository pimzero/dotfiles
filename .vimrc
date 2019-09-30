"""""
" Pimzero's .vimrc
" ================
"
"""
" Todo:
" -----
"
" - Ctags
" - JavaScript (+ evaluate selection or something like this ?)
" - Publish gist
"
"""
" Changelog:
" ---------
"(insert date : ":r !date")
"
" Sat Sep 12 13:56:51 CEST 2015
"   - Removed old clang format integration
"   - Use clang format for vim config
"     (see http://clang.llvm.org/docs/ClangFormat.html)
"
" Thu Jun 25 00:08:01 CEST 2015
"   - Added reset color on quit (avoid breaking `less`)
"
" Wed Jun 10 02:05:49 CEST 2015
"   - Omnisharp
"   - YCM works with omnisharp sever
"   - Separate plugin entries in Vundle and their congiguration
"
" Wed Jun  3 02:50:26 EEST 2015
"   - Clang format integration
"
" Sun Apr 19 20:29:06 CEST 2015
"   - Refactorized title
"
" Fri Apr 17 22:40:45 CEST 2015
"   - Now able to become a markdown file with
"     `cat .vimrc | sed "s/^\"[^ ].*$//g" | sed "s/^\([^\"]\)/\t\1/g" |
"     sed "s/^\"*[\" ]*//g" | sed "s/\(^TODO:.*$\)/*\1*/g"`
"
" Tue Apr 14 18:10:35 CEST 2015
"   - Moved C parts to ./.vim/ftplugin/c.vim
"   - Vundle new version
"
" Sun Feb 15 04:31:43 CET 2015
"   - Working with st terminal emulator.
"
" Sun Oct 12 22:22:31 CEST 2014
"   - Starting versioning
"
"""

"""
" Plugins:
" -------
"""
" Utterly inspired by https://github.com/gmarik/Vundle.vim
" #### Vundle
" (Plugin manager)

" Test if the current setup have vundle

"if filereadable("~/.vim/bundle/Vundle.vim")

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
	"Plugin 'OmniSharp/omnisharp-vim'
	"Plugin 'JuliaLang/julia-vim'
	"Plugin 'file:///home/pim/Workspace/smt-vim-syntax'

	Plugin 'tomasr/molokai'
	let g:molokai_original = 1

	Plugin 'bling/vim-airline'
"Minimap :
	"Plugin 'severin-lemaignan/vim-minimap'
	"Plugin 'file:///home/pim/Workspace/show_asm'
	Plugin 'vim-airline/vim-airline-themes'

	Plugin 'skywind3000/asyncrun.vim'

	Plugin 'rdnetto/YCM-Generator'

	Plugin 'jpalardy/vim-slime'

	call vundle#end()
	filetype plugin indent on


" #### YouCompleteMe
" (Autocompletion)

	let g:ycm_complete_in_strings = 0
	let g:ycm_confirm_extra_conf = 0
	" ^ is bad, we should use g:ycm_extra_conf_globlist or something to
	" whitelist good ycm_extra_conf
	let g:ycm_global_ycm_extra_conf = '/home/pim/.ycm_extra_conf.py'
"let g:ycm_server_python_interpreter = '/usr/bin/python2'
" For C#
"let g:ycm_auto_start_csharp_server = 1
"let g:ycm_auto_stop_csharp_server = 1
"let g:ycm_csharp_server_port = 52666
	let g:ycm_csharp_server_port = 2757
"let g:ycm_filetype_whitelist = { 'c' : 1, 'cpp' : 1 }
"let g:ycm_global_ycm_extra_conf = '~/Workspace/.ycm_extra_conf.py'
"let g:ycm_register_as_syntastic_checker = 0
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_key_list_select_completion = ['<TAB>']
"let g:ycm_key_list_previous_completion = ['<S-TAB>']

" Complete options (disable preview scratch window, longest removed to always
" show menu)
" As they said here :
" https://github.com/Valloric/YouCompleteMe/issues/234

	set completeopt=menu,menuone

" ### Eclim
" (Java Autocomplete)

let g:EclimCompletionMethod = 'omnifunc'

" ### Omnisharp
" (C# Autocompletion)
"autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
	"let g:OmniSharp_port = g:ycm_csharp_server_port
	"let g:OmniSharp_timeout = 10
	"let g:Omnisharp_start_server = 0
	"let g:Omnisharp_stop_server = 0

"#### Powerline
"(Better status line)
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" #### vim-airline
" (Better status line)

	let g:airline_theme='molokai'
	let g:airline_powerline_fonts = 1
	set laststatus=2
"let g:airline_theme='base16'

"endif

" ### vim-slime
" (Ocaml repl)
let g:slime_target = "vimterminal"


"""
" Basics:
" ------
"""

" Syntax

syntax enable

" Encoding

let &termencoding = &encoding
set encoding=utf-8


"""
" Appearance:
" ----------
"""

" ### Theme and colors:

set background=dark
if ($TERM =~ '256color')
	colorscheme molokai
	"colorscheme solarized
	"let g:solarized_hitrail=1
	"let g:solarized_termcolors=256
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
"highlight YcmErrorLine ctermbg=1
"highlight YcmWarningLine ctermbg=3

" Restore initial state for color

"au VimLeave * !echo "c"


" ### Trailing whitespaces and tabs

set list
"set listchars=trail:·
"set listchars=tab:\|\ ,trail:·
set listchars=tab:\⇒\ 


" ### Lines:

" Vertical ruler:

"hi ColorColumn ctermbg=1  " Red background
"set colorcolumn=80        " Two rulers: @80col
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

"This function colorize everything that goes after the 'begin' column
"You may want to use this more than `match` because `match` may be use for
"harder tasks to execute.
"
"function! Colorize_evertyhing_after_pos(begin)
"	let longest = max(map(getline(1, '$'), 'len(v:val)'))
"	let i = a:begin - 1
"	let rulers_pos = a:begin
"	while i <= longest
"		let i += 1
"		let rulers_pos .= ',' . i
"	endwhile
"	let &colorcolumn=rulers_pos
"endfunction

" Cursor line

set cursorline

" Lines number

set number

" Cursor margin

set scrolloff=7
"set numberwidth=5
"Todo: watch 'cpoptions'


" ### Code logic:
" TODO: Code folding
"
" Highlight matching bracket

set showmatch

" No background, red foreground

hi MatchParen cterm=bold ctermbg=none ctermfg=1


"""
" Informations:
" ------------
"""

" ### Title:
" TODO: Read :help 'statusline' seriously and find a way to make something
" cleaner than what i've currently done. Moreover, using autocmd may be better
" BUT it's currently not working with Get_window_title() when using netrw.
"
" TODO: remove all the useless comments, but i keep them righty now because
" some of them have interesting stuff.

set title

"Find a way to show 'Filename - User@Host - VIM' or something like that
"let &titlestring = &titlestring . " - " $USER . "@" . hostname()
" Update Apr 17 2015: I think i prefer this (URL-like) format:
" `[protocol]USER@HOST/PATH/TO/FILE [state]`
"
" TODO: Using autocmd might be better

"BACKUP
"set titlestring=%(%{substitute(substitute(expand(\"%:p\"),\ \"^\"\ .\ $HOME,\ $USER\ .\ \"@\"\ .\ hostname()\ .\ \"/~\",\ \"\"),\ \"^/\",\ $USER\ .\ hostname()\ .\ \"/\",\ \"\")}%)\ %M

function! Get_nice_path(path)
	let user_at_host = $USER . '@' . hostname() . '/'
	let homepath = substitute(a:path, '^' . $HOME, '/~', '')
	return substitute(homepath, '^/', user_at_host, '')
endfunction

set titlestring=%(%{Get_nice_path(expand('%:p'))}%)\ %M

" Explainations:
" (This is pseudo-vim code, won't work as it)
" Get the path with  `expand("%:p")`.
" We then replace the string matched by your `$HOME` by `$USER@$HOSTNAME/~` with
" `substitute('path', "^$HOME", "/~")` to get your homepath clean
" title.
" We append to the title `$USER@$HOSTNAME` the first character is a '/' with
" substitute('homepath', "^/", "$USER@$HOSTANME/")`
" We then append %M at the end, that shows a symbol if the file have been
" changed or not, or if it is read-only.

"""
" Editing:
" -------
"""

" ### Indentation:

" (Moved to `.vim/ftplugin/*.vim`, but there may be usefull stuff for every
" languages to do here)
"Tab to spaces and tab/indent size (currently, 1tab <=> 4spaces)
"set tabstop=4
"set softtabstop=4
"set shiftwidth=4
set tabstop=8
set softtabstop=8
set shiftwidth=8
set smarttab
"set expandtab

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



" ### Mouse:

" Use mouse:

"set mouse=a

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

" ### Cursor:

" Keep cursor position when vim is closed

if has("autocmd")
	au BufReadPost * 
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif

" ### Deletions:

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

" ### Searching:
" TODO: Maybe find some fuzzy-search stuff, maybe use smart case search

set hlsearch    " Highlight search
set incsearch   " Incremental search
set ignorecase  " Ignore case because i'm too lazy to press shift

" ### Clipboard:
" TODO: Reuse my old clipboard stuff, which works completely system-wide (other .vimrc)
"
" Use system-wide clipboard (need +xterm_clipboard)

if has('unnamedplus')
	set clipboard=unnamedplus
else
	set clipboard=unnamed
endif
"Don't auto-indent on paste
"set paste
"(Removed because doesn't auto-indent at all)

" ### History:
" TODO: think about undofile
"
" Command history:

set history=8000

" Edit history:

set undolevels=8000
set showcmd


"""
" Projects:
" --------
"""
" TODO: add some git stuff
"
" Find Makefile path and call make (TODO : Do not call make now, call it when
" needed)

function! Find_and_call_make()
	let makefile_names = ["Makefile", "makefile"]
	let dir=expand("%:p")
	while (strlen(dir) > 1)
		for itr in makefile_names
			if(filereadable(dir . "/" . itr))
				"set makeprg="make -f " . dir . "/" . itr
				execute "set makeprg=make\\ -C\\ " . dir
				make
				return
			endif
		endfor
		let dir=fnamemodify(dir, ':h')
	endwhile
endfunction
noremap <F5> :silent! :call Find_and_call_make() \| :redraw! \| :botright :cw<cr>

"let w:style_police={}
"let w:style_police_hl_col_overflow=-1
"let g:style_police_max_col=80
"
"function! Hl_col_overflow(count)
"	if w:style_police_hl_col_overflow > 0
"		call matchdelete(w:style_police_hl_col_overflow)
"	endif
"
"	for i in getline(1, '$')
"		if len(i) > count
"			let w:style_police[i]='Style: line too long'
"		endif
"	endfor
"	" Todo change 'Error' by something better (see {group-name})
"        let w:style_police_hl_col_overflow=matchadd('Error', '\%>' . a:count .  'v\+')
"endfunction
"
"function! Update_style_warnings()
"	let w:style_police={}
"	call Hl_col_overflow(g:style_police_max_col)
"endfunction
"
"
"

function! Cppgetter()
	:exe "normal Vy"
	:exe "normal p"
	:exe "normal ^v$"
	:'<,'>s/\t*\([^\t].*\)\s\([^ ;]\+\)/\1 \2get() const { return \2; }/g
	:exe "normal \<Esc>"
endfunction


function! Cppsetter()
	:exe "normal Vy"
	:exe "normal p"
	:exe "normal ^v$"
	":'<,'>s/\t*\([^\t]*\)\s\([^ ;]\+\)_/void \2_set(\1 \2) { \2_ = \2; }/g
	:exe "normal \<Esc>"
endfunction



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


function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

"set conceallevel=2
hi Conceal ctermbg=NONE ctermfg=white

function! Framcheck(f)
	:copen
	:AsyncRun frama-c -val expand('%:t') -main a:f -lib-entry
endfunction


"http://vim.wikia.com/wiki/Print_to_a_Postscript_file
let &printexpr="(v:cmdarg=='' ? ".
    \"system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice)".
    \". ' ' . v:fname_in) . delete(v:fname_in) + v:shell_error".
    \" : system('mv '.v:fname_in.' '.v:cmdarg) + v:shell_error)"

set foldlevelstart=99

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
"autocmd FileType ocaml terminal ++close rlwrap ocaml -no-version
