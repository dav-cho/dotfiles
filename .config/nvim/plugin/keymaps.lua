local function map(mode, before, after, opts)
  local options = { noremap = true }
  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.api.nvim_set_keymap(mode, before, after, options)
end

map('n', '<leader>wr', '<cmd>w<CR>', { silent = true })
map('n', '<leader>wa', '<cmd>wa<CR>', { silent = true })
map('n', '<leader>bd', '<cmd>bd<CR>', { silent = true })
map('n', '<leader>n', '<cmd>noh<CR>', { silent = true })
map('n', '<leader>w', '<C-w>', { silent = true })
map('n', 'Y', 'y$', { silent = true })
map('v', '<leader>y', '"*y', { silent = true })
map('n', '<leader>Y', '"*Y', { silent = true })

map('n', '<leader>hh', ':vert h ')
map('n', '<leader>tt', ':Telescope ')

-- Search behavior
map('n', 'n', 'nzzzv', { silent = true })
map('n', 'N', 'Nzzzv', { silent = true })
map('n', '*', '*``', { silent = true })
map('n', '#', '#``', { silent = true })

-- Moving Text
map('n', '<leader>jj', '<cmd>move .+1<CR>==', { silent = true })
map('n', '<leader>kk', '<cmd>move .-2<CR>==', { silent = true })
map('i', '<C-j>', '<esc><cmd>move .+1<CR>==i', { silent = true })
map('i', '<C-k>', '<esc><cmd>move .-2<CR>==i', { silent = true })
-- map('v', '<leader>j', "<cmd>move \'>+1<CR> gv=gv", { silent = true })
-- map('v', '<leader>k', "<cmd>move \'<-2<CR>gv=gv", { silent = true })

