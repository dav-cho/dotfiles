------------------------------ Telescope -----------------------------

local actions = require 'telescope.actions'
local action_state = require('telescope.actions.state')

require('telescope').setup{
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,  -- close telescope with <Esc>
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-a>"] = function()
          print(vim.inspect(action_state.get_selected_entry())) end
      },
      n = {
        --["<C-j>"] = actions.move_selection_next,
        --["<C-k>"] = actions.move_selection_previous,
      },
    }
  },
}

-------------------------------- Maps --------------------------------

---- tjdevries
local tj_map_tele = function(key, f, opts, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format('<cmd>lua R("dav.telescope")["%s"](TelescopeMapArgs["%s"])<CR>', f, map_key)
  local map_options = {
    noremap = true,
    silent = true,
  }

    if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

local map_tele = function(before, after, opts)
  local options = { noremap = true }
  --local options = { noremap = true, silent = true }
  local rhs = string.format('<cmd>Telescope %s<CR>', after)

  if opts then options = opts end

  vim.api.nvim_set_keymap('n', before, rhs, options)
end

map_tele('<leader>tt', '')
map_tele('<leader>ff', 'find_files')
map_tele('<leader>fb', 'file_browser')
map_tele('<leader>bb', 'buffers')
map_tele('<leader>cb', 'current_buffer_fuzzy_find')
map_tele('<leader>tg', 'live_grep')
map_tele('<leader>th', 'help_tags')
--map_tele('<leader>ts', 'treesitter')

----------------------------------------------------------------------

