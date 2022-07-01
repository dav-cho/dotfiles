local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify(string.format('~ %s Call Error!', module))
end

local telescope = prequire 'telescope'
local actions = prequire 'telescope.actions'

telescope.setup {
  defaults = {
    sorting_strategy = 'ascending',

    layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 180 then -- (> 226 columns iterm JetBrainsMono Nerd Font size 14)
            return math.floor(cols * 0.65)
          elseif cols > 150 then -- (> 188 iterm JetBrainsMono Nerd Font size 14)
            return math.floor(cols * 0.55)
          else
            return math.floor(cols * 0.5)
          end
        end,
      },

      vertical = {
        mirror = true,
        preview_height = 0.5,
        preview_cutoff = 40, -- > (44 iterm JetBrainsMono Nerd Font size 14)
      },

      flex = {
        flip_columns = 150,
      },
    },

    color_devicons = true,

    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      }
    },

    file_ignore_patterns = { '^.git/', '^node_modules/' },
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
      case_mode = 'smart_case',
    },
  },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'fzf'
