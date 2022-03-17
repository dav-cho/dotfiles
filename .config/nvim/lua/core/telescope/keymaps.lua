local map_builtin = function(before, after, opts)
  local options = { noremap = true, silent = true }
  local rhs = string.format([[<cmd>lua require('telescope.builtin').%s()<CR>]], after)

  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.api.nvim_set_keymap('n', before, rhs, options)
end

local map_extension = function(before, after, opts)
  local options = { noremap = true, silent = true }
  local rhs = string.format([[<cmd>lua require('telescope').extensions.%s()<CR>]], after)

  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.api.nvim_set_keymap('n', before, rhs, options)
end


map_builtin('<leader>ff', 'find_files')
map_builtin('<leader>fb', 'buffers')
map_builtin('<leader>fc', 'command_history')
map_builtin('<leader>fg', 'live_grep')
map_builtin('<leader>fs', 'current_buffer_fuzzy_find')
map_builtin('<leader>fo', 'oldfiles')
map_builtin('<leader>fh', 'help_tags')

map_extension('<leader>bb', 'file_browser.file_browser')
--vim.api.nvim_set_keymap('n', '<leader>bb', [[<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>]], { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope file_browser<CR>', { noremap = true, silent = true })


-- TODO

--local sorters = prequire('telescope.sorters')
--local sorters = require 'telescope.sorters'


-- Reference
--TelescopeMapArgs = TelescopeMapArgs or {}
--
--local map_tele = function(key, f, options, buffer)
--  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)
--
--  TelescopeMapArgs[map_key] = options or {}
--
--  local mode = "n"
--  local rhs = string.format("<cmd>lua R('core.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)
--
--  local map_options = { noremap = true, silent = true }
--
--  if not buffer then
--    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
--  else
--    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
--  end
--end

