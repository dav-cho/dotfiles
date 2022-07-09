local nnoremap = require("dav.utils.keymap").nnoremap
local inoremap = require("dav.utils.keymap").inoremap
local vnoremap = require("dav.utils.keymap").vnoremap

-- Main
inoremap('<esc>', '<esc>', { nowait = true, silent = true })

nnoremap('<leader>wr', '<cmd>w<CR>', { silent = true })
nnoremap('<leader>wa', '<cmd>wa<CR>', { silent = true })
nnoremap('<leader>fm', vim.lsp.buf.formatting_sync, { silent = true })
nnoremap('<leader>bd', '<cmd>bd<CR>', { silent = true })
nnoremap('<leader>n', '<cmd>noh<CR>', { silent = true })
nnoremap('<leader>w', '<C-w>', { silent = true })

nnoremap('Y', 'y$', { silent = true })
nnoremap('<leader>Y', '"*Y', { silent = true })
vnoremap('<leader>y', '"*y', { silent = true })

nnoremap('<leader>hh', ':vert h ')
nnoremap('<leader>tt', ':Telescope ')

-- Search behavior
nnoremap('n', 'nzzzv', { silent = true })
nnoremap('N', 'Nzzzv', { silent = true })
nnoremap('*', '*``', { silent = true })
nnoremap('#', '#``', { silent = true })

-- Folds
nnoremap('<leader>mv', '<cmd>mkview<CR>')
nnoremap('<leader>lv', '<cmd>loadview<CR>')

-- TODO
-- Moving Text
-- nnoremap('<leader>jj', '<cmd>move .+1<CR>==', { silent = true })
-- nnoremap('<leader>kk', '<cmd>move .-2<CR>==', { silent = true })
-- nnoremap('<C-j>', '<esc><cmd>move .+1<CR>==i', { silent = true })
-- nnoremap('<C-k>', '<esc><cmd>move .-2<CR>==i', { silent = true })
-- nnoremap('<leader>j', "<cmd>move \'>+1<CR> gv=gv", { silent = true })
-- nnoremap('<leader>k', "<cmd>move \'<-2<CR>gv=gv", { silent = true })

