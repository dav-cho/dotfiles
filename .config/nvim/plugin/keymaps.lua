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
map('n', '<leader>bd', '<cmd>bd<CR>', { silent = true })

-- Programatically call <leader>hh? - get text input from command line
--function format_help_str(term)
--  return string.format('<cmd>vert h %s<CR>', term)

map('n', '<leader>hh', ':vert h ')
map('n', '<leader>tt', ':Telescope ')

-- Insert --

-- Visual --



