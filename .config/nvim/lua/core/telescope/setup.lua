local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify(string.format('~ %s Call Error!', module))
end

local telescope = prequire 'telescope'
local actions = prequire 'telescope.actions'

telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',
    },
    color_devicons = true,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
  },

  pickers = {
    find_files = {
      hidden = true,
    },
  },

  extensions = {
    file_browser = {
      initial_mode = 'normal',
      hidden = true,
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
