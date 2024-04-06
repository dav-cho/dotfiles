return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-surround", event = "VeryLazy" },
  {
    "junegunn/fzf",
    lazy = true,
    keys = {
      "zf", -- nvim-bqf
    },
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      local call = require("Comment.api").call

      vim.keymap.set("n", "<C-_>", function()
        return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
      end, { expr = true, silent = true, desc = "[Comment] toggle linewise" })
      vim.keymap.set(
        "v",
        "<C-_>",
        call("toggle.linewise", "g@"),
        { expr = true, silent = true, desc = "[Comment] toggle linewise" }
      )

      require("Comment").setup()
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
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local set_terminal_keymaps = function()
        local options = { buffer = 0 }
        vim.keymap.set("t", "<Esc>", "<C-Bslash><C-n>", options)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = set_terminal_keymaps,
      })
    end,
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
          local api = require("nvim-tree.api")
          local config = nvim_tree.get_config()
          config.view.float.enable = not config.view.float.enable
          nvim_tree.setup(config)
          api.tree.toggle()
        end,
        desc = "[Nvim-Tree] Toggle float",
      },
    },
    opts = {
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
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup(opts)

      vim.cmd("hi link NvimTreeNormalFloat NvimTreeNormal")
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
        "<Leader>yf",
        function()
          require("oil.actions").copy_entry_path.callback()
        end,
        desc = "[Oil] ",
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
    event = "VeryLazy",
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
    "mbbill/undotree",
    keys = {
      { "<Leader>ut", "<Cmd>UndotreeToggle<CR>", desc = "[Undotree] toggle" },
    },
    config = function()
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_DiffpanelHeight = 15
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    lazy = true,
    keys = {
      { "<Leader>fz", "<Cmd>FZF<CR>", silent = true, desc = "[FZF] fzf" },
      { "<Leader>fZ", ":FZF ", silent = true, desc = "[FZF] :FZF" },
    },
    config = function()
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
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Library/CloudStorage/Dropbox/notes/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Library/CloudStorage/Dropbox/notes/**.md",
    },
    keys = {
      { "<leader>oa", "<Cmd>ObsidianOpen<CR>", desc = "[Obsidian] New note" },
      { "<leader>on", ":ObsidianNew ", desc = "[Obsidian] New note" },
      { "<leader>of", "<Cmd>ObsidianFollowLink<CR>", desc = "[Obsidian] Follow link" },
      { "<leader>od", "<Cmd>ObsidianToday<CR>", desc = "[Obsidian] Daily note" },
      { "<leader>os", "<Cmd>ObsidianSearch<CR>", desc = "[Obsidian] Search" },
      { "<leader>ow", "<Cmd>ObsidianWorkspace main<CR>", desc = "[Obsidian] Workspace (main)" },
    },
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/Library/CloudStorage/Dropbox/notes",
        },
      },
      daily_notes = {
        folder = "daily",
        alias_format = "%Y-%m-%d",
        template = "daily.md",
      },
      mappings = {
        ["<Space>-"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      note_id_func = function(title)
        if title ~= nil then
          return title
        end
        return "Untitled"
      end,
      disable_frontmatter = true,
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,
    },
    config = function(_, opts)
      vim.opt_local.conceallevel = 1
      require("obsidian").setup(opts)
    end,
  },
}
