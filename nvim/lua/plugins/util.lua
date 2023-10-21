return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim",   lazy = true },
  { "tpope/vim-repeat",      event = "VeryLazy" },
  { "tpope/vim-surround",    event = "VeryLazy" },
  {
    "junegunn/fzf",
    lazy = true,
    keys = {
      "zf" -- nvim-bqf
    },
    build = function() vim.fn['fzf#install']() end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      local call = require("Comment.api").call

      vim.keymap.set(
        "n",
        "<C-_>",
        function()
          return
              vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)"
              or "<Plug>(comment_toggle_linewise_count)"
        end,
        { expr = true, silent = true, desc = "[Comment] toggle linewise" }
      )
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
        function() require("copilot.suggestion").toggle_auto_trigger() end,
        desc = "[copilot] Toggle auto_trigger"
      },
    },
    opts = {
      panel = {
        auto_refresh = true,
        layout = {
          ratio = 0.3,
        }
      },
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
        desc = "[ToggleTerm] Toggle Float"
      },
      {
        "<M-Bslash>h",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>]],
        desc = "[ToggleTerm] Toggle Horizontal"
      },
      {
        "<M-Bslash>v",
        [[<Cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>]],
        desc = "[ToggleTerm] Toggle Vertical"
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
      { "<Space>;", function() require("nvim-tree.api").tree.toggle() end, desc = "[Nvim-Tree] Toggle" },
      {
        "<Space>'",
        function()
          require("nvim-tree.api").tree.find_file({
            open = true,
            focus = true
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
      { "-", "<Cmd>Oil<CR>",                             desc = "[Oil] Open parent directory" },
      { "_", function() require("oil").open_float() end, desc = "[Oil] Open parent directory in float" },
    },
    opts = {
      default_file_explorer = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["q"] = function()
          local win_id = require("oil.util").get_preview_win()
          if win_id then
            vim.api.nvim_win_close(win_id, true)
          end
          require("oil").close()
        end,
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "<Space>l", function() require("flash").jump() end,       mode = { "n", "x", "o" }, desc = "[Flash] Jump" },
      { "<Space>L", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "[Flash] Treesitter" },
      { "r",        function() require("flash").remote() end,     mode = { "o" },           desc = "[Flash] Remote" },
      {
        "R",
        function() require("flash").treesitter_search() end,
        mode = { "o", "x" },
        desc = "[Flash] Treesitter Search",
      },
      { "<C-t>", function() require("flash").toggle() end, mode = { "c" }, desc = "[Flash] Toggle Search" },
    },
    opts = {
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
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    keys = {
      { "<Leader>md", "<Cmd>MarkdownPreviewToggle<CR>", silent = true }
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
    }
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    lazy = true,
    keys = {
      { "<Leader>fz", function() vim.cmd("FZF") end, silent = true, desc = "[FZF] fzf" },
      { "<Leader>fZ", ":FZF ",                       silent = true, desc = "[FZF] :FZF" },
    },
    config = function()
      vim.api.nvim_create_user_command(
        "Fzf",
        function()
          vim.cmd("call fzf#run(" .. vim.json.encode({
            sink = "e",
            source = "fd --type file --follow --hidden --no-ignore --strip-cwd-prefix",
            tmux = "-p 80%% 80%%",
          }) .. ")")
        end,
        { desc = "[FZF] open ui" }
      )
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    cmd = "ChatGPT",
    keys = function()
      local keymaps = {
        { "<Leader>ai", "<Cmd>ChatGPT<CR>",      desc = ":ChatGPT" },
        { "<Leader>aa", "<Cmd>ChatGPTActAs<CR>", desc = ":ChatGPTActAs" },
        {
          "<Leader>ae",
          "<Cmd>ChatGPTEditWithInstructions<CR>",
          mode = { "n", "v" },
          desc = ":ChatGPTEditWithInstructions"
        },
      }
      for _, keymap in pairs(keymaps) do
        keymap.desc = "[ChatGPT] " .. (keymap.desc or "")
      end
      return keymaps
    end,
    opts = {
      keymaps = {
        submit = "<M-CR>",
      },
    },
  },
}
