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
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      ai = {
        n_lines = 1000,
      },
    },
    config = function(_, opts)
      require("mini.ai").setup(opts.ai)
      require("mini.splitjoin").setup()
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "FZF" },
    keys = {
      { "<Leader>fz", "<Cmd>FZF<CR>", desc = "[FZF] FZF" },
      { "<Leader>rg", "<Cmd>Rg<CR>", desc = "[FZF] Rg" },
      { "<Leader>fl", "<Cmd>Lines<CR>", desc = "[FZF] Lines" },
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
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    keys = {
      {
        "<Leader>cp",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
        end,
        desc = "[copilot] Toggle auto_trigger",
      },
    },
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      "<C-Bslash>",
      {
        "<M-Bslash>f",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>]],
        desc = "[ToggleTerm] Toggle Float",
      },
      {
        "<M-Bslash>h",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>]],
        desc = "[ToggleTerm] Toggle Horizontal",
      },
      {
        "<M-Bslash>v",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>]],
        desc = "[ToggleTerm] Toggle Vertical",
      },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
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
          require("nvim-tree.api").tree.find_file({
            open = true,
            focus = true,
          })
        end,
        desc = "[Nvim-Tree] Find File",
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
          min = 45,
        },
        preserve_window_proportions = true,
        float = {
          enable = true,
          open_win_config = {
            height = math.floor(vim.api.nvim_win_get_height(0) * 0.90),
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      git = {
        ignore = false,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.cmd("hi link NvimTreeNormalFloat NvimTreeNormal")
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      -- { "-", function() require("oil").open() end,       desc = "[Oil] Open" },
      {
        "-",
        function()
          require("oil").open_float()
        end,
        desc = "[Oil] Open float",
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
    },
    opts = {
      default_file_explorer = false,
      columns = {},
      keymaps = {
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-x>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        win_options = {
          winblend = 10,
        },
        override = function(conf)
          conf.height = math.floor(vim.o.lines * 0.3)
          conf.row = (vim.o.lines - conf.height) - 4
          return conf
        end,
      },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "<Leader>/",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "[Flash] Jump",
      },
      {
        "<Leader>?",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "[Flash] Treesitter",
      },
      {
        "r",
        function()
          require("flash").remote()
        end,
        mode = { "o" },
        desc = "[Flash] Remote",
      },
      {
        "R",
        function()
          require("flash").treesitter_search()
        end,
        mode = { "o", "x" },
        desc = "[Flash] Treesitter Search",
      },
      {
        "<C-g>/",
        function()
          require("flash").toggle()
        end,
        mode = { "c" },
        desc = "[Flash] Toggle Search",
      },
    },
    opts = {
      search = {
        mode = "fuzzy",
      },
      label = {
        min_pattern_length = 2,
      },
      highlight = {
        backdrop = false,
      },
      modes = {
        char = {
          enabled = false,
          highlight = { backdrop = false },
        },
      },
      prompt = {
        win_config = {
          row = -3,
        },
      },
      remote_op = {
        restore = true,
      },
    },
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
    -- https://github.com/danymat/neogen?tab=readme-ov-file
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
              annotation_convention = "reST", -- google_docstrings | numpydoc | reST
              reST_typed = rest_typed(),
            },
          },
        },
      }
    end,
  },
}
