" Complete options (disable preview scratch window, longest removed to always
" show menu)
" As they said here :
" https://github.com/Valloric/YouCompleteMe/issues/234
"set completeopt=menu,menuone

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

if has('nvim')
	" Customize settings on a filetype
	call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'nvim-lsp'])
	call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
	      \ 'nvim-lsp': {'mark': 'lsp', 'forceCompletionPattern': '\.\w*|:\w*|->\w*'},
	      \ })
else
	" Customize settings on a filetype
	call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'vim-lsp'])
	call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
	      \ 'vim-lsp': {'mark': 'lsp', 'forceCompletionPattern': '\.\w*|:\w*|->\w*'},
	      \ })
endif
call ddc#custom#patch_filetype('markdown', 'sourceParams', {
      \ 'around': {'maxSize': 100},
      \ })

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()

if has('nvim')
lua << EOF
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "==", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "==", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end
local lsp = require 'lspconfig'
lsp.denols.setup{ on_attach = on_attach }
lsp.gopls.setup{ on_attach = on_attach }
lsp.dartls.setup{ on_attach = on_attach }
lsp.pylsp.setup{ on_attach = on_attach }
lsp.cmake.setup{ on_attach = on_attach }
local clangd_cmd = {
     "clangd", "--clang-tidy",
     "--completion-style=detailed",
     "--fallback-style=webkit"}
if vim.fn.has('mac') == 1 then
  clangd_cmd[#clangd_cmd + 1] = "--compile-commands-dir=build"
end
lsp.clangd.setup {
  cmd = clangd_cmd,
  on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F4>', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
    on_attach(client, bufnr)
  end,
}
--vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
--require'lspconfig'.sumneko.setup{}
EOF
set completeopt-=preview
"let g:lsp_preview_float = 0
"let g:lsp_hover_ui = 'preview'
else
	let g:lsp_diagnostics_echo_cursor = 1
endif
