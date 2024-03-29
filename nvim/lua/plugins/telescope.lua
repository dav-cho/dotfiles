return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = function()
      local keymaps = {
        { "<Space>r",   function() require("telescope.builtin").resume() end,                    desc = "resume" },
        { "<Space>k",   function() require("telescope.builtin").keymaps() end,                   desc = "keymaps" },
        { "<Space>h",   function() require("telescope.builtin").help_tags() end,                 desc = "help_tags" },
        { "<Leader>tm", function() require("telescope.builtin").man_pages() end,                 desc = "man_pages" },
        { "<Leader>co", function() require("telescope.builtin").commands() end,                  desc = "commands" },
        { "<Leader>cs", function() require("telescope.builtin").colorscheme() end,               desc = "colorscheme" },
        { "<Leader>oo", function() require("telescope.builtin").oldfiles() end,                  desc = "oldfiles" },
        { "<Leader>sh", function() require("telescope.builtin").search_history() end,            desc = "search_history" },
        { "<Leader>ch", function() require("telescope.builtin").command_history() end,           desc = "command_history" },
        { "<Space>b",   function() require("telescope.builtin").buffers() end,                   desc = "buffers" },
        { "<Leader>re", function() require("telescope.builtin").registers() end,                 desc = "registers" },
        { "<Leader>ju", function() require("telescope.builtin").jumplist() end,                  desc = "jumplist" },
        { "<Leader>mk", function() require("telescope.builtin").marks() end,                     desc = "marks" },
        { "<Leader>qf", function() require("telescope.builtin").quickfix() end,                  desc = "quickfix" },
        { "<Leader>qF", function() require("telescope.builtin").quickfixhistory() end,           desc = "quickfixhistory" },
        { "<Leader>lc", function() require("telescope.builtin").loclist() end,                   desc = "loclist" },
        { "<Leader>bt", function() require("telescope.builtin").current_buffer_tags() end,       desc = "current_buffer_tags" },
        { "<Leader>sp", function() require("telescope.builtin").spell_suggest() end,             desc = "spell_suggest" },
        { "<Leader>vo", function() require("telescope.builtin").vim_options() end,               desc = "vim_options" },
        { "<Leader>ac", function() require("telescope.builtin").autocommands() end,              desc = "autocommands" },
        { "<Leader>hi", function() require("telescope.builtin").highlights() end,                desc = "highlights" },
        { "<Leader>ts", function() require("telescope.builtin").treesitter() end,                desc = "treesitter" },
        { "<Space>v",   function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "current_buffer_fuzzy_find" },

        {
          "<Space>f",
          function()
            require("telescope.builtin").find_files()
          end,
          desc = "find_files"
        },
        {
          "<Space>F",
          function()
            require("telescope.builtin").find_files({
              cwd = require("telescope.utils").buffer_dir(),
              prompt_title = "Find Files (buf dir)",
            })
          end,
          desc = "find_files (buf dir)",
        },
        {
          "<Space>A",
          function()
            require("telescope.builtin").find_files({
              hidden = true,
              no_ignore = true,
              prompt_title = "Find Files (hidden, no_ignore)",
            })
          end,
          desc = "find_files (hidden, no_ignore)",
        },
        {
          "<Space>a",
          function()
            require("telescope.builtin").find_files({
              cwd = require("telescope.utils").buffer_dir(),
              hidden = true,
              no_ignore = true,
              prompt_title = "Find Files (buf dir, hidden, no_ignore)",
            })
          end,
          desc = "find_files (buf dir, hidden, no_ignore)",
        },

        {
          "<Space>e",
          function()
            require("telescope").extensions.file_browser.file_browser({
              cwd = require("telescope.utils").buffer_dir(),
              prompt_title = "File Browser (buf dir)",
            })
          end,
          desc = "file_browser (buf dir)",
        },
        {
          "<Space>E",
          function()
            require("telescope").extensions.file_browser.file_browser()
          end,
          desc = "file_browser",
        },

        { "<Leader>ll", function() require("telescope.builtin").live_grep() end,           desc = "live_grep" },
        {
          "<Leader>lo",
          function()
            require("telescope.builtin").live_grep({
              grep_open_files = true,
              prompt_title = "Live Grep (Open Files)",
            })
          end,
          desc = "live_grep (open files)",
        },
        {
          "<Leader>lb",
          function()
            require("telescope.builtin").live_grep({
              cwd = require("telescope.utils").buffer_dir(),
              prompt_title = "Live Grep (Buffer Dir)",
            })
          end,
          desc = "live_grep (buf dir)",
        },
        {
          "<Leader>lg",
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
          "<Leader>jj",
          function() require("telescope.builtin").grep_string() end,
          mode = { "n", "x" },
          desc = "grep_string",
        },
        {
          mode = { "n", "x" },
          "<Leader>jo",
          function()
            require("telescope.builtin").grep_string({
              grep_open_files = true,
            })
          end,
          desc = "grep_string (open files)",
        },
        {
          "<Leader>jb",
          function()
            require("telescope.builtin").grep_string({
              search_dirs = { vim.fn.expand("%:h") },
            })
          end,
          mode = { "n", "x" },
          desc = "grep_string (buf dir)",
        },

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
              prompt_title = "Diagnostics (buffer)",
            })
          end,
          desc = "diagnostics (buffer)",
        },
        {
          "<M-D>",
          function() require("telescope.builtin").diagnostics() end,
          desc = "diagnostics (cwd)",
        },
        {
          "<Leader><M-d>",
          function()
            require("telescope.builtin").diagnostics({
              no_unlisted = true,
              prompt_title = "Diagnostics (no unlisted)",
            })
          end,
          desc = "diagnostics (no unlisted)",
        },
        {
          "<Leader>dd",
          function()
            require("telescope.builtin").diagnostics({
              root_dir = require("telescope.utils").buffer_dir(),
              prompt_title = "Diagnostics (buf dir)",
            })
          end,
          desc = "diagnostics (buf dir)",
        },
        {
          "<Leader>DD",
          function() require("telescope.builtin").diagnostics() end,
          desc = "diagnostics",
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
          "<Leader>SS",
          function() require("telescope.builtin").lsp_workspace_symbols() end,
          desc = "lsp_workspace_symbols",
        },
        { "<Leader>ic", function() require("telescope.builtin").lsp_incoming_calls() end,  desc = "lsp_incoming_calls" },
        { "<Leader>oc", function() require("telescope.builtin").lsp_outgoing_calls() end,  desc = "lsp_outgoing_calls" },
        { "<Leader>li", function() require("telescope.builtin").lsp_implementations() end, desc = "lsp_implementations" },
        { "<Leader>ld", function() require("telescope.builtin").lsp_definitions() end,     desc = "lsp_definitions" },
        {
          "<Leader>lt",
          function() require("telescope.builtin").lsp_type_definitions() end,
          desc = "lsp_type_definitions",
        },

        {
          "<Space>g",
          function()
            require("telescope.builtin").git_files()
          end,
          desc = "git_files"
        },
        {
          "<Space>G",
          function()
            require("telescope.builtin").git_files({
              prompt_title = "Git Files (cwd)",
              use_git_root = false,
            })
          end,
          desc = "git_files (cwd)"
        },
        {
          "<Space>o",
          function()
            require("telescope.builtin").git_files({
              prompt_title = "Git Files (others)",
              git_command = { "git", "ls-files", "--others", "--exclude-per-directory", ".gitignore" },
            })
          end,
          desc = "git_files (others)"
        },
        {
          "<Space>O",
          function()
            require("telescope.builtin").git_files({
              prompt_title = "Git Files (others, cwd)",
              use_git_root = false,
              git_command = { "git", "ls-files", "--others", "--exclude-per-directory", ".gitignore" },
            })
          end,
          desc = "git_files (others, cwd)"
        },
        { "<Leader>gb", function() require("telescope.builtin").git_branches() end,       desc = "git_branches" },
        { "<Leader>gl", function() require("telescope.builtin").git_commits() end,        desc = "git_commits" },
        { "<Leader>gL", function() require("telescope.builtin").git_bcommits() end,       desc = "git_bcommits" },
        { "<Leader>gs", function() require("telescope.builtin").git_status() end,         desc = "git_status" },
        { "<Leader>st", function() require("telescope.builtin").git_stash() end,          desc = "git_stash" },
        { "<Leader>bi", function() require("telescope.builtin").builtin() end,            desc = "builtin" },
        { "<Leader>tp", function() require("telescope.builtin").pickers() end,            desc = "pickers" },
        { "<Leader>rl", function() require("telescope.builtin").reloader() end,           desc = "reloader" },

        { "<Leader>no", function() require("telescope").extensions.notify.notify() end,   desc = "notify" },
        { "<Leader>yy", function() require("telescope").extensions.neoclip.default() end, desc = "neoclip" },
        { "<Leader>he", function() require("telescope").extensions.heading.heading() end, desc = "markdown heading" },
        {
          "<Leader>mm",
          function()
            local conf = require("telescope.config").values
            local file_paths = {}
            for _, item in ipairs(require("harpoon"):list().items) do
              table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
            }):find()
          end,
          desc = "Harpoon marks",
        },

        {
          "<Leader>dl",
          function() require("telescope").extensions.dap.list_breakpoints() end,
          desc = "dap.list_breakpoints",
        },
        {
          "<Leader>dpC",
          function() require("telescope").extensions.dap.configurations() end,
          desc = "dap.configurations"
        },
        { "<Leader>dpc", function() require("telescope").extensions.dap.commands() end,  desc = "dap.commands" },
        { "<Leader>dpv", function() require("telescope").extensions.dap.variables() end, desc = "dap.variables" },
        { "<Leader>dpf", function() require("telescope").extensions.dap.frames() end,    desc = "dap.frames" },
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
          layout_strategy = "flex",
          dynamic_preview_title = true,
          winblend = 10,
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<M-p>"] = actions.cycle_previewers_next,
              ["<M-P>"] = layout.toggle_preview,
              ["<M-l>"] = layout.cycle_layout_next,
              ["<M-x>"] = require("trouble.providers.telescope").open_with_trouble,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<M-p>"] = actions.cycle_previewers_next,
              ["<M-P>"] = layout.toggle_preview,
              ["<M-l>"] = layout.cycle_layout_next,
              ["<M-x>"] = require("trouble.providers.telescope").open_with_trouble,
            },
          },
          layout_config = {
            flex = {
              flip_columns = 150,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = {
              "fd",
              "--type",
              "f",
              "--hidden",
              "--exclude",
              ".git",
              "--exclude",
              "node_modules",
              "--exclude",
              "__pycache__",
            },
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
          file_browser = {
            select_buffer = true,
            mappings = {
              i = {
                ["<C-t>"] = actions.select_tab,
                ["<M-t>"] = fb_actions.change_cwd,
                ["<M-i>"] = fb_actions.toggle_respect_gitignore,
              },
              n = {
                ["h"] = false,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<M-i>"] = fb_actions.toggle_respect_gitignore,
              },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          heading = {
            treesitter = true,
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
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim",   lazy = true, build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  { "nvim-telescope/telescope-ui-select.nvim",    lazy = true },
  { "crispgm/telescope-heading.nvim",             lazy = true, ft = "markdown" },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<Leader>un", function() require("telescope").extensions.undo.undo() end, desc = "[Telescope] undo" },
    },
    opts = {
      extensions = {
        undo = {
          use_delta = false,
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },
  {
    "dhruvmanila/browser-bookmarks.nvim",
    version = "*",
    keys = {
      { "<Leader>bo", function() require("telescope").extensions.bookmarks.bookmarks() end, desc = "[Telescope] bookmarks" },
    },
    opts = {
      selected_browser = "chrome",
      full_path = false,
    },
    config = function(_, opts)
      require("browser_bookmarks").setup(opts)
      require("telescope").load_extension("bookmarks")
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = { "y" },
    config = true,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = function()
      local harpoon = require("harpoon")

      local keymaps = {
        { "<Space>m",   function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "[Harpoon] toggle_quick_menu" },
        -- -- TODO: set to alternative list (or cmd list)
        -- { "<Space>M",   function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "[Harpoon] toggle_quick_menu" },
        { "<Leader>ma", function() harpoon:list():append() end,                      desc = "[Harpoon] list append" },
        { "<Leader>mp", function() harpoon:list():prepend() end,                     desc = "[Harpoon] list prepend" },
        { "<Leader>mr", function() harpoon:list():remove() end,                      desc = "[Harpoon] list remove" },
        { "<Leader>mX", function() harpoon:list():clear() end,                       desc = "[Harpoon] list clear" },
        { "<Space>[",   function() harpoon:list():prev() end,                        desc = "[Harpoon] list prev" },
        { "<Space>]",   function() harpoon:list():next() end,                        desc = "[Harpoon] list next" },
        -- { "<Leader>mt", function() require("harpoon.mark").toggle_file() end,        desc = "[Harpoon] toggle_file" },
        -- { "<Space>0",   function() require("harpoon.ui").nav_file(10) end,           desc = "[Harpoon] nav_file(10)" },
      }

      for i = 1, 10 do
        table.insert(keymaps, {
          "<Space>" .. i % 10,
          function() harpoon:list():select(i) end,
          desc = string.format("[Harpoon] nav_file(%d)", i),
        })
      end

      -- for i = 1, 10 do
      --   table.insert(keymaps, {
      --     "<Leader>" .. i % 10,
      --     function()
      --       require("harpoon.term").gotoTerminal(i)
      --     end,
      --     desc = string.format("[Harpoon] gotoTerminal(%d)", i)
      --   })
      -- end

      return keymaps
    end,
    opts = {
      settings = {
        save_on_toggle = true,
        -- sync_on_ui_close = true,
      },
      -- -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2#-api
      -- -- Setting up custom behavior for a list named "cmd"
      -- "cmd" = {
      --
      --   -- When you call list:append() this function is called and the return
      --   -- value will be put in the list at the end.
      --   --
      --   -- which means same behavior for prepend except where in the list the
      --   -- return value is added
      --   --
      --   -- @param possible_value string only passed in when you alter the ui manual
      --   add = function(possible_value)
      --     -- get the current line idx
      --     local idx = vim.fn.line(".")
      --
      --     -- read the current line
      --     local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
      --     if cmd == nil then
      --       return nil
      --     end
      --
      --     return {
      --       value = cmd,
      --       context = { ... any data you want ... },
      --     }
      --   end,
      --
      --   --- This function gets invoked with the options being passed in from
      --   --- list:select(index, <...options...>)
      --   --- @param list_item {value: any, context: any}
      --   --- @param list { ... }
      --   --- @param option any
      --   select = function(list_item, list, option)
      --     -- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
      --     vim.cmd(list_item.value)
      --   end
      -- }
    },
    config = function(_, opts)
      local harpoon = require("harpoon")
      local extensions = require("harpoon.extensions");

      harpoon:setup(opts)

      harpoon:extend({
        UI_CREATE = function(cx)
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-x>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-t>", function()
            harpoon.ui:select_menu_item({ tabedit = true })
          end, { buffer = cx.bufnr })
        end,
      })

      harpoon:extend(extensions.builtins.navigate_with_number());
    end,
  },
}
