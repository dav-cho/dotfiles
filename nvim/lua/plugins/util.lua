return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-surround", event = "VeryLazy" },
  {
    "numToStr/Comment.nvim",
    keys = {
      {
        "<C-_>",
        function()
          return vim.api.nvim_get_vvar("count") == 0 and "<Plug>(comment_toggle_linewise_current)"
            or "<Plug>(comment_toggle_linewise_count)"
        end,
        expr = true,
        silent = true,
        desc = "<Plug>(comment_toggle_linewise_current|comment_toggle_linewise_count)",
      },
      {
        "<C-_>",
        function()
          return "<Plug>(comment_toggle_linewise_visual)"
        end,
        mode = "v",
        expr = true,
        silent = true,
        desc = "<Plug>(comment_toggle_linewise_visual)",
      },
      {
        "<M-Y>",
        function()
          vim.cmd("normal! ygv")
          vim.api.nvim_input("gc")
        end,
        mode = "v",
        desc = "[Comment] Yank selection and comment",
      },
      {
        "<M-?>",
        function()
          vim.cmd("normal! vip")
          vim.api.nvim_input("gc")
        end,
        desc = "[Comment] Comment paragraph",
      },
      {
        "<Leader>#",
        function()
          vim.api.nvim_input("gcOTODO<Esc>")
        end,
        desc = "[Comment] TODO above",
      },
      {
        "<Leader>$",
        function()
          vim.api.nvim_input("gcATODO<Esc>")
        end,
        desc = "[Comment] TODO EOL",
      },
      {
        "<Space>#",
        function()
          vim.api.nvim_input("gcOTODO: ")
        end,
        desc = "[Comment] TODO above (insert mode)",
      },
      {
        "<Space>$",
        function()
          vim.api.nvim_input("gcATODO: ")
        end,
        desc = "[Comment] TODO EOL (insert mode)",
      },
    },
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      "<C-Bslash>",
      {
        "<M-T>\\",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>]],
        desc = "[ToggleTerm] Toggle Float",
      },
      {
        "<M-T>s",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>]],
        desc = "[ToggleTerm] Toggle Horizontal",
      },
      {
        "<M-T>v",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>]],
        desc = "[ToggleTerm] Toggle Vertical",
      },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.5
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.5
        end
      end,
      open_mapping = "<C-Bslash>",
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 10,
      },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      {
        "<Leader>uu",
        function()
          vim.cmd.UndotreeToggle()
          vim.cmd.UndotreeFocus()
        end,
        desc = "[Undotree] Toggle + focus",
      },
      { "<Leader>ut", vim.cmd.UndotreeToggle, desc = "[Undotree] Toggle" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      {
        "<M-->",
        function()
          require("oil").open_float()
        end,
        desc = "[Oil] Open float",
      },
      {
        "<M-_>",
        function()
          require("oil").open()
        end,
        desc = "[Oil] Open",
      },
      {
        "<Leader>yp",
        function()
          require("oil.actions").copy_entry_path.callback()
        end,
        desc = "[Oil] copy_entry_path",
      },
      {
        "<Leader>ca",
        function()
          if vim.bo.filetype == "oil" then
            require("oil").discard_all_changes()
          end
        end,
        desc = "[Oil] Discard all changes",
      },
      {
        "<C-v>",
        function()
          require("oil.actions").select_vsplit.callback()
        end,
        ft = "oil",
        desc = "[Oil] Select vsplit",
      },
    },
    opts = {
      default_file_explorer = false,
      keymaps = {
        ["q"] = "actions.close",
        ["<Leader>wv"] = "actions.select_vsplit",
        ["<Leader>ws"] = "actions.select_split",
        ["<Leader>yy"] = { "actions.yank_entry", opts = { modify = ":~:." }, desc = "[Oil] Yank relative path" },
        ["<Leader>YY"] = { "actions.yank_entry", desc = "[Oil] Yank absolute path" },
        ["<Leader>yf"] = { "actions.yank_entry", opts = { modify = ":t" }, desc = "[Oil] Yank file name" },
        ["<Leader>qa"] = {
          desc = "Append entry to quickfix list",
          callback = function()
            require("oil.actions").add_to_qflist.callback()
          end,
        },
        ["gd"] = {
          desc = "[Oil] Toggle file detail view",
          callback = (function()
            local default = nil
            local all = { "icon", "permissions", "size", "mtime" }
            return function()
              default = default or require("oil.config").columns
              if vim.deep_equal(default, require("oil.config").columns) then
                require("oil").set_columns(all)
              else
                require("oil").set_columns(default)
              end
            end
          end)(),
        },
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
        override = function(conf)
          local files = vim.list_extend(
            vim.fn.glob(vim.fn.expand("%:p:h") .. "/*", false, true),
            vim.fn.glob(vim.fn.expand("%:p:h") .. "/.*", false, true)
          )
          conf.height = #files - 1
          conf.row = (vim.o.lines - conf.height) - 4
          return conf
        end,
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      {
        "<Space>;",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        desc = "[Nvim-Tree] Toggle",
      },
      {
        "<Space>'",
        function()
          require("nvim-tree.api").tree.toggle({ find_file = true })
        end,
        desc = "[Nvim-Tree] Toggle (find file)",
      },
      {
        "<Space>:",
        function()
          local nvim_tree = require("nvim-tree")
          local config = nvim_tree.get_config()
          config.view.float.enable = not config.view.float.enable
          nvim_tree.setup(config)
          require("nvim-tree.api").tree.toggle()
        end,
        desc = "[Nvim-Tree] Toggle float",
      },
    },
    opts = {
      hijack_netrw = false,
      view = {
        width = {
          min = 50,
        },
        preserve_window_proportions = true,
        float = {
          enable = true,
          open_win_config = {
            col = 0,
            row = 2,
            height = math.floor(vim.api.nvim_win_get_height(0) * 0.90),
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = { enable = false },
        },
      },
      git = { ignore = false },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.cmd("hi link NvimTreeNormalFloat NvimTreeNormal")
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "FZF" },
    keys = {
      { "<Leader>fz", "<Cmd>FZF<CR>", desc = "[FZF] FZF" },
      { "<Leader>bl", "<Cmd>BLines<CR>", desc = "[FZF] BLines" },
      { "<Leader>fh", "<Cmd>History<CR>", desc = "[FZF] History" },
      {
        "<Leader>FZ",
        function()
          local input = vim.fn.input("FZF: ")
          if input ~= "" then
            vim.cmd("FZF " .. input)
          end
        end,
        silent = true,
        desc = "[FZF] :FZF {args}",
      },
      {
        "<Leader>RG",
        function()
          local input = vim.fn.input("Rg: ")
          if input ~= "" then
            vim.cmd("Rg " .. input)
          end
        end,
        silent = true,
        desc = "[FZF] :Rg {pattern}",
      },
    },
    config = function()
      -- vim.g.fzf_layout = { tmux = "-p85%,85%"}
      vim.g.fzf_layout = { window = { width = 0.80, height = 0.80 } }

      vim.api.nvim_create_user_command("Fzf", function()
        vim.cmd("call fzf#run(" .. vim.json.encode({
          sink = "e",
          source = "fd --type file --follow --hidden --no-ignore --strip-cwd-prefix",
          tmux = "-p 80%% 80%%",
        }) .. ")")
      end, { desc = "[FZF] open ui" })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("Fzf", {}),
        pattern = { "fzf" },
        callback = function(ev)
          vim.bo[ev.buf].buflisted = false
          vim.keymap.set("n", "<Esc>", "<Cmd>close<CR>", { buffer = ev.buf, silent = true })
        end,
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<Leader>fr",
        function()
          require("fzf-lua").resume()
        end,
        desc = "[fzf-lua] files",
      },

      {
        "<Leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "[fzf-lua] files",
      },
      {
        "<Leader>qq",
        function()
          require("fzf-lua").quickfix()
        end,
        desc = "[fzf-lua] quickfix",
      },
      {
        "<Leader>qs",
        function()
          require("fzf-lua").quickfix_stack()
        end,
        desc = "[fzf-lua] quickfix_stack",
      },

      {
        "<Leader>fg",
        function()
          require("fzf-lua").grep()
        end,
        desc = "[fzf-lua] grep",
      },
      {
        "<Leader>fG",
        function()
          require("fzf-lua").grep_last()
        end,
        desc = "[fzf-lua] grep_last",
      },
      {
        "<Leader>fw",
        function()
          require("fzf-lua").grep_cword()
        end,
        desc = "[fzf-lua] grep_cword",
      },
      {
        "<Leader>fW",
        function()
          require("fzf-lua").grep_cWORD()
        end,
        desc = "[fzf-lua] grep_cWORD",
      },
      {
        "<Leader>fb",
        function()
          require("fzf-lua").grep_curbuf()
        end,
        desc = "[fzf-lua] grep_curbuf",
      },
      {
        "<Leader>fl",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "[fzf-lua] live_grep",
      },
      {
        "<Leader>fL",
        function()
          require("fzf-lua").live_grep_resume()
        end,
        desc = "[fzf-lua] live_grep_resume",
      },

      {
        "<Leader>fm",
        function()
          require("fzf-lua").manpages()
        end,
        desc = "[fzf-lua] manpages",
      },
    },
    opts = {
      winopts = {
        backdrop = 100,
        preview = {
          horizontal = "right:50%",
        },
        on_create = function()
          vim.keymap.set("n", "<Esc>", function()
            require("fzf-lua").hide()
          end, { buffer = 0 })
          vim.keymap.set("n", "<Tab>", "i<C-j><Esc>", { buffer = 0 })
        end,
      },
    },
  },
  {
    "folke/persistence.nvim",
    enabled = false,
    event = "BufReadPre",
    opts = {},
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
      {
        "<Leader>ng",
        function()
          require("neogen").generate()
        end,
        desc = "[Neogen] generate()",
      },
      {
        "<Leader>nt",
        function()
          require("neogen").generate({
            annotation_convention = {
              python = "reST_typed",
            },
          })
        end,
        desc = "[Neogen] generate() (typed)",
      },
      {
        "<Leader>nc",
        function()
          local choice = vim.ui.select({ "func", "class", "type", "file" }, {}, function(choice)
            require("neogen").generate({ type = choice })
          end)
          print(choice)
        end,
        desc = "[Neogen] generate()",
      },
      {
        "<M-d><M-s>",
        function()
          require("neogen").generate()
        end,
        mode = { "i" },
        desc = "[Neogen] generate()",
      },
      {
        "<M-D><M-S>",
        function()
          require("neogen").generate({
            annotation_convention = {
              python = "reST_typed",
            },
          })
        end,
        mode = { "i" },
        desc = "[Neogen] generate() (typed)",
      },
    },
    opts = function()
      local rest_typed = function()
        local i = require("neogen.types.template").item
        return {
          { nil, '"""$1"""', { no_results = true, type = { "class", "func" } } },
          { nil, '"""$1', { no_results = true, type = { "file" } } },
          { nil, "", { no_results = true, type = { "file" } } },
          { nil, "$1", { no_results = true, type = { "file" } } },
          { nil, '"""', { no_results = true, type = { "file" } } },
          { nil, "", { no_results = true, type = { "file" } } },

          { nil, "# $1", { no_results = true, type = { "type" } } },

          { nil, '"""$1' },
          { nil, "" },
          {
            i.Parameter,
            ":param %s: $1",
            {
              type = { "func" },
              after_each = ":type %s: $1",
            },
          },
          {
            { i.Parameter, i.Type },
            ":param %s: $1",
            {
              type = { "func" },
              required = i.Tparam,
              after_each = ":type %s: %s",
            },
          },
          {
            i.ClassAttribute,
            ":param %s: $1",
            {
              type = { "class" },
              after_each = ":type %s: $1",
            },
          },
          {
            i.Throw,
            ":raises %s: $1",
            {
              type = { "func" },
            },
          },
          {
            i.Return,
            ":return: $1",
            {
              after_each = ":rtype: $1",
              type = { "func" },
            },
          },
          {
            i.ReturnTypeHint,
            ":return: $1",
            {
              after_each = ":rtype: %s",
              type = { "func" },
            },
          },
          { nil, '"""' },
        }
      end

      return {
        snippet_engine = "luasnip",
        enable_placeholders = false,
        placeholders_hl = "None",
        languages = {
          python = {
            template = {
              annotation_convention = "reST",
              reST_typed = rest_typed(),
            },
          },
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    keys = {
      { "<Leader>md", "<Cmd>MarkdownPreviewToggle<CR>", silent = true },
    },
    config = function()
      vim.g.mkdp_preview_options = { sync_scroll_type = "relative" }
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_echo_preview_url = 1
    end,
  },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.splitjoin").setup()
    end,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    version = "*",
    opts = {
      global = {
        paste_window = {
          winblend = 30,
          yank_register_enabled = false,
        },
      },
      tmux = {
        kitty_get_text = {
          extent = "last_cmd_output",
        },
      },
    },

    config = function(_, opts)
      require("kitty-scrollback").setup(opts)
      vim.keymap.set("n", "q", "<Cmd>q!<CR>", { buffer = 0, silent = true })
    end,
  },
  {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = function(ctx)
        return ctx.plugin and 200 or 400
      end,
      win = {
        wo = {
          winblend = 10,
        },
      },
      layout = {
        align = "center",
      },
    },
    keys = {
      {
        "<Space>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    keys = {
      "<Leader>aa",
      "<Leader>ae",
      "<Leader>af",
      "<Leader>ah",
      "<Leader>as",
      "<Leader>at",
      "<Leader>aR",
    },
    version = false,
    build = "make",
    opts = {
      hints = {
        enabled = false,
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "Avante" },
    opts = {
      file_types = { "Avante" },
    },
  },
}
