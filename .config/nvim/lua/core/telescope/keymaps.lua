local map_tele = function(before, after, opts)
  local options = { noremap = true, silent = true }
  local rhs = string.format('<cmd>Telescope %s<CR>', after)

  if opts then
    for k, v in pairs(opts) do
      options[k] = v
    end
  end

  vim.api.nvim_set_keymap('n', before, rhs, options)
end

map_tele('<leader>ff', 'find_files')
--map_tele('<leader>FF', 'find_browser') -- TODO: Add... Deprecated?
map_tele('<leader>fb', 'buffers')
map_tele('<leader>fc', 'command_history')
map_tele('<leader>fs', 'current_buffer_fuzzy_find')
map_tele('<leader>fg', 'live_grep')
map_tele('<leader>fh', 'help_tags')

-- TODO
-- _ = require("telescope").load_extension "file_browser"

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

