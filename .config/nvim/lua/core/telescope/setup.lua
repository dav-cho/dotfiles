local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify(string.format('~ %s Call Error!', module))
end

local telescope = prequire 'telescope'
local actions = prequire 'telescope.actions'

-- TODO: add rg

telescope.setup {
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
    },

  },

  --pickers = {
  --  -- Default configuration for builtin pickers goes here:
  --  -- picker_name = {
  --    picker_config_key = value,
  --    ...
  --  }
  --  Now the picker_config_key will be applied every time you call this
  --  builtin picker
  --},

  extensions = {
    file_browser = {
      initial_mode = 'normal',
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'fzf'

