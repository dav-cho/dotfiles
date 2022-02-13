""----------------------------- Python -------------------------------

set shiftwidth=4
set tabstop=4 softtabstop=4
set expandtab autoindent smartindent
set colorcolumn=80
"set colorcolumn=88
"set noswapfile

nnoremap <C-k> 5k
nnoremap <leader>py :w !python<CR>
nnoremap <leader>pi :term python % <CR>
"nnoremap <leader>f <cmd>w | !black %<CR>
"nnoremap <leader>f :w | !black %
nnoremap <leader>f <cmd>!black %<CR>
"nnoremap <leader>f <cmd>!black %


""--------------------------------------------------------------------

