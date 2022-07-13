if not pcall(require, "telescope") then
	return
end

local actions = require "telescope.actions"

-- TODO
-- local action_state = require "telescope.actions.state"
-- local action_layout = require "telescope.actions.layout"
-- 
-- local set_prompt_to_entry_value = function(prompt_bufnr)
--   local entry = action_state.get_selected_entry()
--   if not entry or not type(entry) == "table" then
--     return
--   end
-- 
--   action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
-- end

require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",

    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",

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
      },

      flex = {
        flip_columns = 150,
      },
    },

    color_devicons = true,

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },

    file_ignore_patterns = { "^.git/", "^node_modules/" },
  },

  pickers = {
    find_files = {
      hidden = true,
    },
  },

  extensions = {
    file_browser = {
      initial_mode = "normal",
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

require("telescope").load_extension "file_browser"
require("telescope").load_extension "fzf"
require("telescope").load_extension "dap"
