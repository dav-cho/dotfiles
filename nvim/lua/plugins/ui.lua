return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "onsails/lspkind-nvim",
    lazy = true,
    config = function()
      require("lspkind").init()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disable_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            icons_enabled = false,
            symbols = { error = " ", warn = " ", hint = " ", info = " " },
          },
        },
        lualine_c = {
          {
            "%F %m",
            cond = function()
              return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype", "filesize" },
        lualine_y = {
          {
            function()
              local cursor = vim.fn.line(".")
              local total = vim.fn.line("$")
              local percentage = math.floor(cursor / total * 100) .. "%%"

              return percentage
            end,
          },
        },
        lualine_z = { "location" }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "UIEnter",
    keys = function()
      local keymaps = {
        { "<BS>",       function() require("bufferline").cycle(1) end,                    desc = "BufferLineCycleNext" },
        { "<Del>",      function() require("bufferline").cycle(-1) end,                   desc = "BufferLineCyclePrev" },
        { "<Space>>",   function() require("bufferline").move(1) end,                     desc = "BufferLineMoveNext" },
        { "<Space><",   function() require("bufferline").move(-1) end,                    desc = "BufferLineMovePrev" },
        { "<Space>p",   function() require("bufferline").pick() end,                      desc = "BufferlinePick" },
        { "<Space>c",   function() require("bufferline").close_with_pick() end,           desc = "BufferLinePickClose" },
        { "<leader>bp", function() require("bufferline.groups").toggle_pin() end,         desc = "BufferLineTogglePin" },
        { "<leader>br", function() require("bufferline").restore_positions() end,         desc = "restore_positions()" },
        { "<leader>Bh", function() require("bufferline").close_in_direction("left") end,  desc = "BufferLineCloseLeft" },
        { "<leader>Bl", function() require("bufferline").close_in_direction("right") end, desc = "BufferLineCloseRight" },
        { "<leader>Bt", function() require("bufferline").sort_by("tabs") end,             desc = "BufferLineSortByTabs" },
        {
          "<leader>Be",
          function() require("bufferline").sort_by("extension") end,
          desc = "BufferLineSortByExtension",
        },
        {
          "<leader>Bd",
          function() require("bufferline").sort_by("directory") end,
          desc = "BufferLineSortByDirectory",
        },
        {
          "<leader>Br",
          function() require("bufferline").sort_by("relative_directory") end,
          desc = "BufferLineSortByRelativeDirectory",
        },
      }

      for _, keymap in pairs(keymaps) do
        keymap.desc = "[BufferLine] " .. (keymap.desc or "")
      end

      return keymaps
    end,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        options = {
          style_preset = 4, -- bufferline style preset no italics
          close_command = "bdelete %d",
          left_mouse_command = "buffer %d",
          right_mouse_command = "bdelete %d",
          max_name_length = 30,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = true,
          diagnostics_indicator = function(count, level, _, context)
            local icon = level:match("error") and " " or " "
            if context.buffer:current() then
              return icon .. count
            end
            return ""
          end,
          sort_by = "insert_after_current",
          groups = {
            items = {
              require("bufferline.groups").builtin.pinned:with({ icon = "" }),
            },
          },
        },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "UIEnter",
    keys = {
      {
        "<leader>nx",
        function() require("notify").dismiss({ silent = true, pending = true }) end,
        desc = "[Notify] Delete all Notifications",
      },
    },
    opts = {
      stages = "static",
      timeout = 3000,
    },
    config = function(_, _opts)
      require("notify").setup(_opts)

      local log = require("plenary.log").new {
        plugin = "notify",
        level = "debug",
        use_console = false,
      }

      vim.notify = function(msg, level, opts)
        log.info(msg, level, opts)

        require("notify")(msg, level, opts)
      end
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = { "junegunn/fzf" },
    ft = "qf",
    opts = {
      auto_resize_height = true,
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = function()
      local keymaps = {
        { "<Space>x",   "<Cmd>TroubleToggle<CR>",                       desc = "Toggle" },
        { "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>",  desc = "Toggle document_diagnostics" },
        { "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Toggle workspace_diagnostics" },
        { "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>",              desc = "Toggle quickfix" },
        { "<leader>xl", "<Cmd>TroubleToggle loclist<CR>",               desc = "Toggle loclist" },
        { "<leader>xr", "<Cmd>TroubleToggle lsp_references<CR>",        desc = "Toggle lsp_references" },
        { "<leader>xt", "<Cmd>TroubleToggle lsp_type_definitions<CR>",  desc = "Toggle lsp_type_definitions" },
        { "<leader>xi", "<Cmd>TroubleToggle lsp_implementations<CR>",   desc = "Toggle lsp_implementations" },
      }

      for _, keymap in pairs(keymaps) do
        keymap.silent = true
        keymap.desc = "[Trouble] " .. (keymap.desc or "")
      end

      return keymaps
    end,
    opts = {
      mode = "document_diagnostics",
      padding = false,
      action_keys = {
        jump = { "<CR>", "<2-leftmouse>" },
        hover = { "K", "gh" },
        previous = { "k", "<S-Tab>" },
        next = { "j", "<Tab>" },
      },
      auto_jump = {},
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "VeryLazy",
    keys = {
      { "zR", function() require("ufo").openAllFolds() end,  desc = "[UFO] Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "[UFO] Close all folds" },
      {
        "zp",
        function()
          if not require("ufo").peekFoldedLinesUnderCursor() then
            vim.lsp.buf.hover()
          end
        end,
        desc = "[UFO] Peek folded lines under cursor",
      },
      "zj",
      "zk",
      "]z",
      "[z",
    },
    opts = {
      open_fold_hl_timeout = 100,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("   ⋯ 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may be less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
    },
    config = function(_, opts)
      local ufo = require("ufo")

      ufo.setup(opts)

      local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

      local next_fold, prev_fold = repeatable_move.make_repeatable_move_pair(
        function() vim.cmd("normal! zj") end,
        function() vim.cmd("normal! zk") end
      )

      local next_closed, prev_closed = repeatable_move.make_repeatable_move_pair(
        ufo.goNextClosedFold, ufo.goPreviousClosedFold
      )

      vim.keymap.set({ "n", "x", "o" }, "zj", next_fold, { silent = true, desc = "[UFO] Move downwards to next fold" })
      vim.keymap.set({ "n", "x", "o" }, "zk", prev_fold, { silent = true, desc = "[UFO] Move upwards to next fold" })
      vim.keymap.set({ "n", "x", "o" }, "]z", next_closed, { silent = true, desc = "[UFO] Next closed fold" })
      vim.keymap.set({ "n", "x", "o" }, "[z", prev_closed, { silent = true, desc = "[UFO] Previous closed fold" })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = {
      { "<leader>ib", "<Cmd>IBLToggle<CR>",      silent = true, desc = "[IndentBlankline] Toggle" },
      { "<leader>is", "<Cmd>IBLToggleScope<CR>", silent = true, desc = "[IndentBlankline] Toggle Scope" },
    },
    opts = function(_, opts)
      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        vim.api.nvim_set_hl(0, "IndentBlanklineDark", { fg = "#262626" })
      end)

      return vim.tbl_deep_extend("force", opts, {
        enabled = false,
        indent = {
          char = "▏",
          highlight = "IndentBlanklineDark",
        },
        scope = {
          show_start = false,
          show_end = false,
          highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
          },
          include = {
            node_type = { ["*"] = "*" },
          },
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = {
      {
        "<leader>zz",
        function()
          require("zen-mode").toggle({ plugins = { twilight = { enabled = false } } })
        end,
        silent = true,
        desc = "[Zen Mode] Toggle",
      },
      {
        "<leader>zt",
        function()
          require("zen-mode").toggle({ plugins = { twilight = { enabled = true } } })
        end,
        silent = true,
        desc = "[Zen Mode] Toggle with Twilight",
      },
    },
    opts = {
      window = {
        backdrop = 1,
        width = 300,
      },
    },
  },
  {
    "folke/twilight.nvim",
    keys = {
      {
        "<leader>tw",
        function()
          require("twilight").setup()
          require("twilight").toggle()
        end,
        silent = true,
        desc = "[Twilight] Toggle"
      },
      {
        "<leader>tf",
        function()
          require("twilight").setup({ context = 0 })
          require("twilight").toggle()
        end,
        silent = true,
        desc = "[Twilight] Toggle (context = 0)",
      },
    },
    config = true,
  },
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    config = function()
      require("colorizer").setup({
        "css",
        "javascript",
        "typescript",
      }, {
        mode = "background", -- foreground, background
      })
    end,
  },
}
