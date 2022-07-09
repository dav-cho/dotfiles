setlocal shiftwidth=4
setlocal tabstop=4 softtabstop=4
setlocal colorcolumn=89

nnoremap <buffer><silent> <leader>py :!python %<CR>
" nnoremap <buffer><silent> <leader>py :w !python<CR>
nnoremap <buffer><silent> <leader>pe :!pipenv run python %<CR>
nnoremap <buffer><silent> <leader>pi :term python % <CR>
