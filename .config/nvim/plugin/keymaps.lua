-- Modes
--  normal = 'n'
--  insert = 'i'
--  visual = 'v'
--  visual block = 'x'
--  term = 't'
--  command = 'c'

local map = require 'utils.map'

-- Normal --
map('n', '<leader>wr', '<cmd>w<CR>', { silent = true }) -- moved to main init
map('n', '<leader>n', '<cmd>noh<CR>', { silent = true })
map('n', '<leader>w', '<C-w>', { silent = true })
--map('n', '<C-k>', '5k', { silent = true })
--map('n', '<C-j>', '5j', { silent = true })
map('n', '<leader>bd', '<cmd>bd<CR>', { silent = true })

-- Insert --

-- Visual --



