return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "plenary.nvim",
      "telescope-fzf-native.nvim",
    },
    keys = function()
      local function telescope_builtin(name, opts)
        return function()
          require("telescope.builtin")[name](opts or {})
        end
      end

      local keymaps = {
        { "<Space>r", telescope_builtin("resume"), desc = "resume" },
        { "<Space>k", telescope_builtin("keymaps"), desc = "keymaps" },
        { "<Space>h", telescope_builtin("help_tags"), desc = "help_tags" },
        { "<Space>b", telescope_builtin("buffers"), desc = "buffers" },
        { "<Space>v", telescope_builtin("current_buffer_fuzzy_find"), desc = "current_buffer_fuzzy_find" },
        { "<Leader>ac", telescope_builtin("autocommands"), desc = "autocommands" },
        { "<Leader>bi", telescope_builtin("builtin"), desc = "builtin" },
        { "<Leader>bt", telescope_builtin("current_buffer_tags"), desc = "current_buffer_tags" },
        { "<Leader>ch", telescope_builtin("command_history"), desc = "command_history" },
        { "<Leader>co", telescope_builtin("commands"), desc = "commands" },
        { "<Leader>cs", telescope_builtin("colorscheme"), desc = "colorscheme" },
        { "<Leader>hi", telescope_builtin("highlights"), desc = "highlights" },
        { "<Leader>ju", telescope_builtin("jumplist"), desc = "jumplist" },
        { "<Leader>lc", telescope_builtin("loclist"), desc = "loclist" },
        { "<Leader>mk", telescope_builtin("marks"), desc = "marks" },
        { "<Leader>oo", telescope_builtin("oldfiles"), desc = "oldfiles" },
        { "<Leader>qF", telescope_builtin("quickfixhistory"), desc = "quickfixhistory" },
        { "<Leader>qf", telescope_builtin("quickfix"), desc = "quickfix" },
        { "<Leader>re", telescope_builtin("registers"), desc = "registers" },
        { "<Leader>rl", telescope_builtin("reloader"), desc = "reloader" },
        { "<Leader>sh", telescope_builtin("search_history"), desc = "search_history" },
        { "<Leader>sp", telescope_builtin("spell_suggest"), desc = "spell_suggest" },
        { "<Leader>tm", telescope_builtin("man_pages"), desc = "man_pages" },
        { "<Leader>tp", telescope_builtin("pickers"), desc = "pickers" },
        { "<Leader>ts", telescope_builtin("treesitter"), desc = "treesitter" },
        { "<Leader>vo", telescope_builtin("vim_options"), desc = "vim_options" },

        { "<Space>f", telescope_builtin("find_files"), desc = "find_files" },
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
          "<Space>a",
          telescope_builtin("find_files", {
            hidden = true,
            no_ignore = true,
            prompt_title = "Find Files (hidden, no_ignore)",
          }),
          desc = "find_files (hidden, no_ignore)",
        },
        {
          "<Space>A",
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
              hidden = true,
              prompt_title = "File Browser (buf dir)",
            })
          end,
          desc = "file_browser (buf dir)",
        },
        {
          "<Space>E",
          function()
            require("telescope").extensions.file_browser.file_browser({ hidden = true })
          end,
          desc = "file_browser",
        },

        { "<Leader>ll", telescope_builtin("live_grep"), desc = "live_grep" },
        {
          "<Leader>lo",
          telescope_builtin("live_grep", {
            grep_open_files = true,
            prompt_title = "Live Grep (Open Files)",
          }),
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
            vim.ui.input({ prompt = "Glob > ", completion = "file" }, function(input)
              glob = input
            end)
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
          telescope_builtin("grep_string"),
          mode = { "n", "x" },
          desc = "grep_string",
        },
        {
          "<Leader>jo",
          telescope_builtin("grep_string", { grep_open_files = true }),
          mode = { "n", "x" },
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
          telescope_builtin("lsp_references", {
            include_current_line = true,
            ump_type = "never",
            fname_width = 50,
          }),
          desc = "lsp_references",
        },
        {
          "<M-d>",
          telescope_builtin("diagnostics", {
            bufnr = 0,
            prompt_title = "Diagnostics (buffer)",
          }),
          desc = "diagnostics (buffer)",
        },
        { "<M-D>", telescope_builtin("diagnostics"), desc = "diagnostics (workspace)" },
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
        { "<Space>i", telescope_builtin("lsp_document_symbols"), desc = "lsp_document_symbols" },
        { "<Space>I", telescope_builtin("lsp_dynamic_workspace_symbols"), desc = "lsp_dynamic_workspace_symbols" },
        { "<Leader>SS", telescope_builtin("lsp_workspace_symbols"), desc = "lsp_workspace_symbols" },
        { "<Leader>ic", telescope_builtin("lsp_incoming_calls"), desc = "lsp_incoming_calls" },
        { "<Leader>oc", telescope_builtin("lsp_outgoing_calls"), desc = "lsp_outgoing_calls" },
        { "<Leader>li", telescope_builtin("lsp_implementations"), desc = "lsp_implementations" },
        { "<Leader>ld", telescope_builtin("lsp_definitions"), desc = "lsp_definitions" },
        { "<Leader>lt", telescope_builtin("lsp_type_definitions"), desc = "lsp_type_definitions" },

        { "<Space>g", telescope_builtin("git_files"), desc = "git_files" },
        {
          "<Space>G",
          telescope_builtin("git_files", {
            prompt_title = "Git Files (cwd)",
            use_git_root = false,
          }),
          desc = "git_files (cwd)",
        },
        {
          "<Space>o",
          telescope_builtin("git_files", {
            prompt_title = "Git Files (others)",
            git_command = { "git", "ls-files", "--others", "--exclude-per-directory", ".gitignore" },
          }),
          desc = "git_files (others)",
        },
        {
          "<Space>O",
          telescope_builtin("git_files", {
            prompt_title = "Git Files (others, cwd)",
            use_git_root = false,
            git_command = { "git", "ls-files", "--others", "--exclude-per-directory", ".gitignore" },
          }),
          desc = "git_files (others, cwd)",
        },
        { "<Leader>gb", telescope_builtin("git_branches"), desc = "git_branches" },
        { "<Leader>gl", telescope_builtin("git_commits"), desc = "git_commits" },
        { "<Leader>gL", telescope_builtin("git_bcommits"), desc = "git_bcommits" },
        { "<Leader>gs", telescope_builtin("git_status"), desc = "git_status" },
        { "<Leader>st", telescope_builtin("git_stash"), desc = "git_stash" },

        {
          "<Leader>no",
          function()
            require("telescope").extensions.notify.notify()
          end,
          desc = "notify",
        },
        {
          "<Leader>he",
          function()
            require("telescope").extensions.heading.heading()
          end,
          desc = "markdown heading",
        },
        {
          "<Leader>mm",
          function()
            local conf = require("telescope.config").values
            local file_paths = {}
            for _, item in ipairs(require("harpoon"):list().items) do
              table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
              .new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                  results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
              })
              :find()
          end,
          desc = "Harpoon marks",
        },
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
      local fb_actions = require("telescope._extensions.file_browser.actions")

      local function yank_path(modifiers)
        return function()
          local entry = state.get_selected_entry()
          local path = vim.fn.fnamemodify(entry.path, modifiers or "")
          vim.fn.setreg("+", path)
        end
      end

      return {
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          dynamic_preview_title = true,
          winblend = 10,
          layout_config = {
            prompt_position = "top",
            flex = {
              flip_columns = 160,
            },
            horizontal = {
              preview_width = 0.5,
            },
            vertical = {
              mirror = true,
            },
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-y>"] = yank_path(":."),
              ["<M-p>"] = actions.cycle_previewers_next,
              ["<M-P>"] = layout.toggle_preview,
              ["<M-l>"] = layout.cycle_layout_next,
              ["<M-y>"] = yank_path(":~"),
              ["<M-x>"] = require("trouble.sources.telescope").open,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-y>"] = yank_path(":."),
              ["<M-p>"] = actions.cycle_previewers_next,
              ["<M-P>"] = layout.toggle_preview,
              ["<M-l>"] = layout.cycle_layout_next,
              ["<M-y>"] = yank_path(":~"),
              ["<M-x>"] = require("trouble.sources.telescope").open,
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
                ["<M-c>"] = fb_actions.create,
              },
              n = {
                ["h"] = false,
                ["c"] = false,
                ["w"] = false,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<M-i>"] = fb_actions.toggle_respect_gitignore,
                ["<M-c>"] = fb_actions.create,
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
      telescope.load_extension("ui-select")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", lazy = true, build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
  { "crispgm/telescope-heading.nvim", lazy = true, ft = "markdown" },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<Leader>un",
        function()
          require("telescope").extensions.undo.undo()
        end,
        desc = "[Telescope] undo",
      },
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
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "TextYankPost",
    keys = {
      {
        "<Leader>yy",
        function()
          require("telescope").extensions.neoclip.default()
        end,
        desc = "neoclip",
      },
    },
    config = true,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "plenary.nvim",
      "telescope.nvim",
    },
    keys = function()
      local harpoon = require("harpoon")

      local keymaps = {
        {
          "<Space>m",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "[Harpoon] toggle_quick_menu",
        },
        {
          "<Leader>ma",
          function()
            harpoon:list():add()
          end,
          desc = "[Harpoon] list append",
        },
        {
          "<Leader>mp",
          function()
            harpoon:list():prepend()
          end,
          desc = "[Harpoon] list prepend",
        },
        {
          "<Leader>mr",
          function()
            harpoon:list():remove()
          end,
          desc = "[Harpoon] list remove",
        },
        {
          "<Leader>mu",
          function()
            harpoon:list():remove()
            harpoon:list():add()
          end,
          desc = "[Harpoon] update",
        },
        {
          "<Leader>mX",
          function()
            harpoon:list():clear()
          end,
          desc = "[Harpoon] list clear",
        },
        {
          "<Space>[",
          function()
            harpoon:list():prev()
          end,
          desc = "[Harpoon] list prev",
        },
        {
          "<Space>]",
          function()
            harpoon:list():next()
          end,
          desc = "[Harpoon] list next",
        },
      }

      for i = 1, 10 do
        table.insert(keymaps, {
          "<Space>" .. i % 10,
          function()
            harpoon:list():select(i)
          end,
          desc = string.format("[Harpoon] nav_file(%d)", i),
        })
      end

      return keymaps
    end,
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    config = function(_, opts)
      local harpoon = require("harpoon")
      local extensions = require("harpoon.extensions")

      harpoon:setup(opts)

      local extend_ui_keys = {
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
      }

      local make_relative = function(abs_path, dir)
        local path = require("plenary.path"):new(abs_path)
        return path:make_relative(dir or vim.loop.cwd())
      end

      local sync_index_with_current_file = {
        LIST_READ = function(list)
          local file = make_relative(vim.api.nvim_buf_get_name(0))
          for i, item in ipairs(list.items) do
            if item.value == file then
              list._index = i
            end
          end
        end,
        UI_CREATE = function(cx)
          local current_file = make_relative(cx.current_file)
          local contents = require("harpoon.buffer").get_contents(cx.bufnr)
          for i, file in ipairs(contents) do
            if file == current_file then
              harpoon:list()._index = i
              vim.api.nvim_win_set_cursor(cx.win_id, { i, 0 })
            end
          end
        end,
      }

      harpoon:extend(extend_ui_keys)
      harpoon:extend(sync_index_with_current_file)
      harpoon:extend(extensions.builtins.command_on_nav("edit"))
      harpoon:extend(extensions.builtins.command_on_nav("lua vim.api.nvim_input('zz')"))
      harpoon:extend(extensions.builtins.navigate_with_number())

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("HarpoonCustom", {}),
        pattern = "harpoon",
        callback = function(_)
          local length = require("harpoon"):list()._length
          local max_width = math.floor(vim.o.columns * 0.5)
          local max_height = math.floor(vim.o.lines * 0.5)

          local config = vim.api.nvim_win_get_config(0)
          local height = math.max(10, math.min(max_height, length))
          local width = math.min(max_width, config.width)
          local cfg = {
            height = height,
            width = width,
            row = math.floor((vim.o.lines - height) / 2),
            col = math.floor((vim.o.columns - width) / 2),
          }
          vim.api.nvim_win_set_config(0, vim.tbl_deep_extend("force", config, cfg))
        end,
      })
    end,
  },
}
