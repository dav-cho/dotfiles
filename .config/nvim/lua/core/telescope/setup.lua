local prequire = require 'utils.prequire'

local telescope = prequire 'telescope'
local actions = prequire 'telescope.actions'
local devicons = prequire 'nvim-web-devicons'
local icons = prequire 'core.icons'

telescope.setup{
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = 'top',
      -- TODO: Set up different layout for vertical
    },
    color_devicons = true,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  },
--  pickers = {
--    -- Default configuration for builtin pickers goes here:
--    -- picker_name = {
--    --   picker_config_key = value,
--    --   ...
--    -- }
--    -- Now the picker_config_key will be applied every time you call this
--    -- builtin picker
--  },
--  extensions = {
--    -- Your extension configuration goes here:
--    -- extension_name = {
--    --   extension_config_key = value,
--    -- }
--    -- please take a look at the readme of the extension you want to configure
--  },
}

