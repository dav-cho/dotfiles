local map_tele = function(before, type, after, opts)  -- type = 'builtin' | 'extensions' | etc...
  local options = { noremap = true, silent = true }

  local rhs = ''
  if type == 'builtin' then
    rhs = string.format("<cmd>lua require('telescope.%s').%s()<CR>", type, after)
  elseif type == 'extensions' then
    rhs = string.format("<cmd>lua require('telescope').%s.%s()<CR>", type, after)
  else
    vim.notify('~ Invalid Type')
  end

  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.api.nvim_set_keymap('n', before, rhs, options)
end

map_tele('<leader>ff', 'builtin', 'find_files')
map_tele('<leader>fb', 'builtin', 'buffers')
map_tele('<leader>fc', 'builtin', 'command_history')
map_tele('<leader>fg', 'builtin', 'live_grep')
map_tele('<leader>fs', 'builtin', 'current_buffer_fuzzy_find')
map_tele('<leader>fo', 'builtin', 'oldfiles')
map_tele('<leader>fh', 'builtin', 'help_tags')
map_tele('<leader>bb', 'extensions', 'file_browser.file_browser')

-- local map_builtin = function(before, after, opts)
--   local options = { noremap = true, silent = true }
--   local rhs = string.format([[<cmd>lua require('telescope.builtin').%s()<CR>]], after)
--
--   options = vim.tbl_deep_extend('force', options, opts or {})
--   vim.api.nvim_set_keymap('n', before, rhs, options)
-- end
--
-- map_builtin('<leader>ff', 'find_files')
-- map_builtin('<leader>fb', 'buffers')
-- map_builtin('<leader>fc', 'command_history')
-- map_builtin('<leader>fg', 'live_grep')
-- map_builtin('<leader>fs', 'current_buffer_fuzzy_find')
-- map_builtin('<leader>fo', 'oldfiles')
-- map_builtin('<leader>fh', 'help_tags')
--
-- local map_extension = function(before, after, opts)
--   local options = { noremap = true, silent = true }
--   local rhs = string.format([[<cmd>lua require('telescope').extensions.%s()<CR>]], after)
--
--   options = vim.tbl_deep_extend('force', options, opts or {})
--   vim.api.nvim_set_keymap('n', before, rhs, options)
-- end
--
-- map_extension('<leader>bb', 'file_browser.file_browser')

