return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = function()
      local keymaps = {
        { "<Space>r",   function() require("telescope.builtin").resume() end,      desc = "resume" },
        { "<Space>k",   function() require("telescope.builtin").keymaps() end,     desc = "keymaps" },
        { "<Space>h",   function() require("telescope.builtin").help_tags() end,   desc = "help_tags" },
        { "<leader>mn", function() require("telescope.builtin").man_pages() end,   desc = "man_pages" },
        { "<leader>co", function() require("telescope.builtin").commands() end,    desc = "commands" },
        { "<leader>cs", function() require("telescope.builtin").colorscheme() end, desc = "colorscheme" },
        { "<Space>f",   function() require("telescope.builtin").find_files() end,  desc = "find_files" },
        {
          "<Space>g",
          function()
            require("telescope.builtin").find_files({
              no_ignore = true,
              hidden = false,
            })
          end,
          desc = "find_files (no_ignore, hidden)",
        },
        {
          "<leader>ff",
          function()
            require("telescope.builtin").find_files({
              cwd = require("telescope.utils").buffer_dir(),
            })
          end,
          desc = "find_files (buf dir)",
        },
        {
          "<leader>FF",
          function()
            require("telescope.builtin").find_files({
              cwd = require("telescope.utils").buffer_dir(),
              no_ignore = true,
              hidden = false,
            })
          end,
          desc = "find_files (buf dir, no_ignore, hidden)",
        },
        { "<leader>oo", function() require("telescope.builtin").oldfiles() end,  desc = "oldfiles" },
        { "<leader>gf", function() require("telescope.builtin").git_files() end, desc = "git_files" },
        { "<leader>ll", function() require("telescope.builtin").live_grep() end, desc = "live_grep" },
        {
          "<leader>lo",
          function()
            require("telescope.builtin").live_grep({
              grep_open_files = true,
              prompt_title = "Live Grep (Open Files)",
            })
          end,
          desc = "live_grep (open files)",
        },
        {
          "<leader>lb",
          function()
            require("telescope.builtin").live_grep({
              cwd = require("telescope.utils").buffer_dir(),
              prompt_title = "Live Grep (Buffer Dir)",
            })
          end,
          desc = "live_grep (buf dir)",
        },
        {
          "<leader>lg",
          function()
            local glob
            vim.ui.input({ prompt = "Glob > ", completion = "file" }, function(input) glob = input end)
            vim.notify(vim.inspect(glob))
            if glob == "" then
              return
            end
            require("telescope.builtin").live_grep({
              glob_pattern = glob,
              additional_args = { "--case-sensitive" },
              prompt_title = "Glob: " .. glob,
            })
          end,
          desc = "live_grep (glob)",
        },
        {
          "<leader>jj",
          function() require("telescope.builtin").grep_string() end,
          mode = { "n", "x" },
          desc = "grep_string",
        },
        {
          mode = { "n", "x" },
          "<leader>jo",
          function()
            require("telescope.builtin").grep_string({
              grep_open_files = true,
            })
          end,
          desc = "grep_string (open files)",
        },
        {
          "<leader>jb",
          function()
            require("telescope.builtin").grep_string({
              search_dirs = { vim.fn.expand("%:h") },
            })
          end,
          mode = { "n", "x" },
          desc = "grep_string (buf dir)",
        },
        {
          "<Space>v",
          function() require("telescope.builtin").current_buffer_fuzzy_find() end,
          desc = "current_buffer_fuzzy_find",
        },
        { "<leader>sh", function() require("telescope.builtin").search_history() end,      desc = "search_history" },
        { "<leader>ch", function() require("telescope.builtin").command_history() end,     desc = "command_history" },
        { "<Space>o",   function() require("telescope.builtin").buffers() end,             desc = "buffers" },
        { "<leader>re", function() require("telescope.builtin").registers() end,           desc = "registers" },
        { "<leader>ju", function() require("telescope.builtin").jumplist() end,            desc = "jumplist" },
        { "<leader>ma", function() require("telescope.builtin").marks() end,               desc = "marks" },
        { "<leader>qf", function() require("telescope.builtin").quickfix() end,            desc = "quickfix" },
        { "<leader>qF", function() require("telescope.builtin").quickfixhistory() end,     desc = "quickfixhistory" },
        { "<leader>lc", function() require("telescope.builtin").loclist() end,             desc = "loclist" },
        { "<leader>bt", function() require("telescope.builtin").current_buffer_tags() end, desc = "current_buffer_tags" },
        { "<leader>sp", function() require("telescope.builtin").spell_suggest() end,       desc = "spell_suggest" },
        { "<leader>vo", function() require("telescope.builtin").vim_options() end,         desc = "vim_options" },
        { "<leader>ac", function() require("telescope.builtin").autocommands() end,        desc = "autocommands" },
        { "<leader>hi", function() require("telescope.builtin").highlights() end,          desc = "highlights" },
        {
          "<F12>",
          function()
            require("telescope.builtin").lsp_references({
              include_current_line = true,
              ump_type = "never",
              fname_width = 50,
            })
          end,
          desc = "lsp_references",
        },
        {
          "<M-d>",
          function()
            require("telescope.builtin").diagnostics({
              bufnr = 0,
            })
          end,
          desc = "diagnostics (buffer)",
        },
        {
          "<M-D>",
          function()
            require("telescope.builtin").diagnostics({
              no_unlisted = true,
            })
          end,
          desc = "diagnostics (no unlisted)",
        },
        {
          "<leader>dd",
          function()
            require("telescope.builtin").diagnostics({
              root_dir = require("telescope.utils").buffer_dir(),
            })
          end,
          desc = "diagnostics (buf dir)",
        },
        {
          "<leader>DD",
          function() require("telescope.builtin").diagnostics() end,
          desc = "diagnostics",
        },
        {
          "<leader><M-D>",
          function() require("telescope.builtin").diagnostics() end,
          desc = "diagnostics (cwd)",
        },
        {
          "<Space>i",
          function() require("telescope.builtin").lsp_document_symbols() end,
          desc = "lsp_document_symbols",
        },
        {
          "<Space>I",
          function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
          desc = "lsp_dynamic_workspace_symbols",
        },
        {
          "<leader>SS",
          function() require("telescope.builtin").lsp_workspace_symbols() end,
          desc = "lsp_workspace_symbols",
        },
        { "<leader>ic", function() require("telescope.builtin").lsp_incoming_calls() end,  desc = "lsp_incoming_calls" },
        { "<leader>oc", function() require("telescope.builtin").lsp_outgoing_calls() end,  desc = "lsp_outgoing_calls" },
        { "<leader>li", function() require("telescope.builtin").lsp_implementations() end, desc = "lsp_implementations" },
        { "<leader>ld", function() require("telescope.builtin").lsp_definitions() end,     desc = "lsp_definitions" },
        {
          "<leader>lt",
          function() require("telescope.builtin").lsp_type_definitions() end,
          desc = "lsp_type_definitions",
        },
        { "<leader>ts", function() require("telescope.builtin").treesitter() end,   desc = "treesitter" },
        { "<leader>gb", function() require("telescope.builtin").git_branches() end, desc = "git_branches" },
        { "<leader>gl", function() require("telescope.builtin").git_commits() end,  desc = "git_commits" },
        { "<leader>gL", function() require("telescope.builtin").git_bcommits() end, desc = "git_bcommits" },
        { "<leader>gs", function() require("telescope.builtin").git_status() end,   desc = "git_status" },
        { "<leader>st", function() require("telescope.builtin").git_stash() end,    desc = "git_stash" },
        { "<leader>bi", function() require("telescope.builtin").builtin() end,      desc = "builtin" },
        { "<leader>tp", function() require("telescope.builtin").pickers() end,      desc = "pickers" },
        { "<leader>rl", function() require("telescope.builtin").reloader() end,     desc = "reloader" },
        {
          "<Space>b",
          function()
            require("telescope").extensions.file_browser.file_browser({
              cwd = require("telescope.utils").buffer_dir(),
              select_buffer = true,
            })
          end,
          desc = "file_browser (buf dir)",
        },
        {
          "<Space>B",
          function()
            require("telescope").extensions.file_browser.file_browser({
              cwd = require("telescope.utils").buffer_dir(),
              select_buffer = true,
              respect_gitignore = false,
            })
          end,
          desc = "file_browser (buf dir, no respect gitignore)",
        },
        {
          "<leader>bb",
          function() require("telescope").extensions.file_browser.file_browser() end,
          desc = "file_browser",
        },
        {
          "<leader>BB",
          function()
            require("telescope").extensions.file_browser.file_browser({
              respect_gitignore = false,
            })
          end,
          desc = "file_browser (no respect gitignore)",
        },
        { "<leader>no", function() require("telescope").extensions.notify.notify() end,   desc = "notify" },
        { "<Space>m",   function() require("telescope").extensions.harpoon.marks() end,   desc = "Harpoon marks" },
        { "<leader>yy", function() require("telescope").extensions.neoclip.default() end, desc = "neoclip" },
        { "<leader>un", function() require("telescope").extensions.undo.undo() end,       desc = "undo" },
        { "<leader>he", function() require("telescope").extensions.heading.heading() end, desc = "markdown heading" },
        {
          "<leader>dl",
          function() require("telescope").extensions.dap.list_breakpoints() end,
          desc = "dap.list_breakpoints",
        },
        {
          "<leader>dpC",
          function() require("telescope").extensions.dap.configurations() end,
          desc = "dap.configurations"
        },
        { "<leader>dpc", function() require("telescope").extensions.dap.commands() end,        desc = "dap.commands" },
        { "<leader>dpv", function() require("telescope").extensions.dap.variables() end,       desc = "dap.variables" },
        { "<leader>dpf", function() require("telescope").extensions.dap.frames() end,          desc = "dap.frames" },
        { "<leader>bo",  function() require("telescope").extensions.bookmarks.bookmarks() end, desc = "bookmarks" },
      }

      for _, keymap in pairs(keymaps) do
        keymap.silent = true
        keymap.desc = "[Telescope] " .. (keymap.desc or "")
      end

      return keymaps
    end,
    opts = function()
      local actions = require("telescope.actions")
      local layout = require("telescope.actions.layout")
      local state = require("telescope.actions.state")
      local builtin = require("telescope.builtin")
      local fb_actions = require("telescope._extensions.file_browser.actions")
      local trouble = require("trouble.providers.telescope")

      local live_grep_select_dir = function(prompt_bufnr)
        require("telescope").extensions.file_browser.file_browser({
          files = false,
          depth = false,
          attach_mappings = function(prompt_bufnr)
            require("telescope.actions").select_default:replace(function()
              local entry_path = state.get_selected_entry().Path
              local dir = entry_path:is_dir() and entry_path or entry_path:parent()

              builtin.live_grep({
                results_title = dir:make_relative(vim.fn.getcwd()) .. "/",
                cwd = dir:absolute(),
                default_text = state.get_current_line(),
              })
            end)

            return true
          end,
        })
      end

      local open_using = function(finder)
        return function(prompt_bufnr)
          local current_finder = state.get_current_picker(prompt_bufnr).finder
          local entry = state.get_selected_entry()

          local entry_path = entry.ordinal == ".."
              and require("plenary.path"):new(current_finder.path)
              or entry.Path
          local path = entry_path:is_dir() and entry_path:absolute() or entry_path:parent():absolute()

          actions.close(prompt_bufnr)
          finder({ cwd = path })
        end
      end

      return {
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          color_devicons = true,
          file_ignore_patterns = { "^.git/", "^node_modules/", "__pycache__" },
          dynamic_preview_title = true,
          results_title = false,
          winblend = 10,
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<M-p>"] = layout.toggle_preview,
              ["<M-x>"] = trouble.open_with_trouble,
            },
            n = {
              ["<M-p>"] = layout.toggle_preview,
              ["<M-x>"] = trouble.open_with_trouble,
            },
          },
          layout_config = {
            prompt_position = "top",
            flex = {
              flip_columns = 150,
            },
            horizontal = {
              preview_width = 0.5,
            },
            vertical = {
              mirror = true,
              preview_height = 0.5,
            }
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "fd", "--type", "f" },
          },
          live_grep = {
            mappings = {
              i = {
                ["<C-f>"] = live_grep_select_dir,
              },
              n = {
                ["<C-f>"] = live_grep_select_dir,
              },
            },
          },
          buffers = {
            mappings = {
              i = {
                ["<M-c>"] = actions.delete_buffer,
              },
              n = {
                ["<M-c>"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          file_browser = {
            initial_mode = "normal",
            hidden = true,
            mappings = {
              i = {
                ["<C-t>"] = actions.select_tab,
                ["<M-t>"] = fb_actions.change_cwd,
                ["<M-b>"] = open_using(builtin.find_files),
                ["<M-l>"] = open_using(builtin.live_grep)
              },
              n = {
                ["<M-b>"] = open_using(builtin.find_files),
                ["<M-l>"] = open_using(builtin.live_grep)
              },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          heading = {
            treesitter = true,
          },
          undo = {
            initial_mode = "normal",
            use_delta = false,
          },
          bookmarks = {
            selected_browser = "chrome",
            full_path = false,
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("ui-select")
      telescope.load_extension("heading")
      telescope.load_extension("undo")
      telescope.load_extension("bookmarks")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim",   lazy = true, build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  { "nvim-telescope/telescope-ui-select.nvim",    lazy = true },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = { "y" },
    config = true,
  },
  { "crispgm/telescope-heading.nvim", lazy = true, ft = "markdown" },
  { "debugloop/telescope-undo.nvim",  lazy = true },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = function()
      local keymaps = {
        { "<M-h><M-a>", function() require("harpoon.mark").add_file() end,        desc = "[Harpoon] add_file" },
        { "<M-h><M-h>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "[Harpoon] toggle_quick_menu" },
      }

      for i = 1, 9 do
        table.insert(keymaps,
          { "<M-h>" .. i, function() require("harpoon.ui").nav_file(i) end, desc = "[Harpoon] nav_file" })
      end

      for i = 1, 9 do
        table.insert(keymaps,
          {
            ("<M-h><M-%d>"):format(i),
            function()
              vim.cmd("tabe %")
              require("harpoon.term").gotoTerminal(i)
            end,
            desc = "[Harpoon] gotoTerminal"
          })
      end

      return keymaps
    end,
    config = true,
  },
  { "dhruvmanila/telescope-bookmarks.nvim", lazy = true, version = "*" },
}
