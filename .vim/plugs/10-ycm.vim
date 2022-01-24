" ### YouCompleteMe
" (Autocompletion)

Plugin 'Valloric/YouCompleteMe'

let g:ycm_complete_in_strings = 0
let g:ycm_confirm_extra_conf = 0
" ^ is bad, we should use g:ycm_extra_conf_globlist or something to
let g:ycm_global_ycm_extra_conf = '/home/pim/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_enable_diagnostic_signs = 0
