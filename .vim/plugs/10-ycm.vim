"" ### YouCompleteMe
"" (Autocompletion)
"
"Plugin 'Valloric/YouCompleteMe'
"
"let g:ycm_complete_in_strings = 0
"let g:ycm_confirm_extra_conf = 0
"" ^ is bad, we should use g:ycm_extra_conf_globlist or something to
"let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py'
"let g:ycm_enable_diagnostic_highlighting = 1
"let g:ycm_enable_diagnostic_signs = 0

Plugin 'Shougo/ddc.vim'
Plugin 'vim-denops/denops.vim'
" Install your sources
Plugin 'Shougo/ddc-around'

" Install your filters
Plugin 'Shougo/ddc-matcher_head'
Plugin 'Shougo/ddc-sorter_rank'


if has('nvim')
	Plugin 'Shougo/ddc-nvim-lsp'
	Plugin 'neovim/nvim-lspconfig'
else
	Plugin 'shun/ddc-vim-lsp'
	Plugin 'prabirshrestha/vim-lsp'
	Plugin 'mattn/vim-lsp-settings'
endif
