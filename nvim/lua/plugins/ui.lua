return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
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
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", hint = " ", info = " " },
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_c = {
          {
            "%F %m",
            cond = function()
              return vim.fn.empty(vim.fn.expand("%")) ~= 1
            end,
          },
        },
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
          "filesize",
        },
        lualine_y = {
          "progress",
        },
        lualine_z = {
          "location",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
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
        {
          "<Tab>",
          function()
            require("bufferline").cycle(math.max(1, vim.v.count))
          end,
          desc = "BufferLineCyclePrev",
        },
        {
          "<S-Tab>",
          function()
            require("bufferline").cycle(math.min(-1, -vim.v.count))
          end,
          desc = "BufferLineCyclePrev",
        },
        {
          "<Right>",
          function()
            require("bufferline").cycle(math.max(1, vim.v.count))
          end,
          desc = "BufferLineCyclePrev",
        },
        {
          "<Left>",
          function()
            require("bufferline").cycle(math.min(-1, -vim.v.count))
          end,
          desc = "BufferLineCyclePrev",
        },
        {
          "<Space><Right>",
          function()
            require("bufferline").move(1)
          end,
          desc = "BufferLineMoveNext",
        },
        {
          "<Space><Left>",
          function()
            require("bufferline").move(-1)
          end,
          desc = "BufferLineMovePrev",
        },
        {
          "<Space>p",
          function()
            require("bufferline").pick()
          end,
          desc = "BufferlinePick",
        },
        {
          "<Space>c",
          function()
            require("bufferline").close_with_pick()
          end,
          desc = "BufferLinePickClose",
        },
        {
          "<Leader>bp",
          function()
            require("bufferline.groups").toggle_pin()
          end,
          desc = "BufferLineTogglePin",
        },
        {
          "<Leader>br",
          function()
            require("bufferline").restore_positions()
          end,
          desc = "restore_positions()",
        },
        {
          "<Leader>Bh",
          function()
            require("bufferline").close_in_direction("left")
          end,
          desc = "BufferLineCloseLeft",
        },
        {
          "<Leader>Bl",
          function()
            require("bufferline").close_in_direction("right")
          end,
          desc = "BufferLineCloseRight",
        },
        {
          "<Leader>Bt",
          function()
            require("bufferline").sort_by("tabs")
          end,
          desc = "BufferLineSortByTabs",
        },
        {
          "<Leader>Be",
          function()
            require("bufferline").sort_by("extension")
          end,
          desc = "BufferLineSortByExtension",
        },
        {
          "<Leader>Bd",
          function()
            require("bufferline").sort_by("directory")
          end,
          desc = "BufferLineSortByDirectory",
        },
        {
          "<Leader>Br",
          function()
            require("bufferline").sort_by("relative_directory")
          end,
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
        "<Leader>nx",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "[Notify] Delete all Notifications",
      },
    },
    opts = {
      stages = "static",
      timeout = 3000,
    },
    config = function(_, _opts)
      require("notify").setup(_opts)

      local log = require("plenary.log").new({
        plugin = "notify",
        level = "debug",
        use_console = false,
      })

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
      preview = {
        win_height = 24,
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = function()
      local trouble_next, trouble_prev = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        function()
          require("trouble").previous({ skip_groups = true, jump = true })
        end
      )

      return {
        {
          "<Leader>xx",
          function()
            require("trouble").toggle("lsp_document_symbols")
          end,
          desc = "[Trouble] Toggle",
        },
        {
          "<Leader>xd",
          function()
            require("trouble").toggle("document_diagnostics")
          end,
          desc = "[Trouble] document_diagnostics",
        },
        {
          "<Leader>xw",
          function()
            require("trouble").toggle("workspace_diagnostics")
          end,
          desc = "[Trouble] workspace_diagnostics",
        },
        {
          "<Leader>xq",
          function()
            require("trouble").toggle("quickfix")
          end,
          desc = "[Trouble] quickfix",
        },
        {
          "<Leader>xl",
          function()
            require("trouble").toggle("loclist")
          end,
          desc = "[Trouble] loclist",
        },
        {
          "<Leader>xr",
          function()
            require("trouble").toggle("lsp_references")
          end,
          desc = "[Trouble] lsp_references",
        },
        {
          "<Leader>xt",
          function()
            require("trouble").toggle("lsp_type_definitions")
          end,
          desc = "[Trouble] lsp_type_definitions",
        },
        {
          "<Leader>xi",
          function()
            require("trouble").toggle("lsp_implementations")
          end,
          desc = "[Trouble] lsp_implementations",
        },
        { "<Leader>xn", trouble_next, desc = "[Trouble] next" },
        { "<Leader>xp", trouble_prev, desc = "[Trouble] prev" },
      }
    end,
    opts = {
      auto_preview = true,
      focus = true,
      follow = false,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = {
      { "<Leader>ib", "<Cmd>IBLToggle<CR>", silent = true, desc = "[IndentBlankline] Toggle" },
    },
    opts = {
      enabled = false,
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    keys = {
      {
        "<Leader>is",
        function()
          vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
        end,
        silent = true,
        desc = "[mini.indentscope] Toggle",
      },
      {
        "<Leader>ia",
        function()
          require("ibl").update({ enabled = not require("ibl.config").get_config(-1).enabled })
          vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
        end,
        silent = true,
        desc = "Toggle indent lines and scope",
      },
    },
    opts = {
      draw = {
        delay = 50,
        animation = function(s, n)
          return 3
        end,
      },
      mappings = {
        object_scope = "ii",
        object_scope_with_border = "ai",
        goto_top = "[i",
        goto_bottom = "]i",
      },
      options = {
        border = "top", -- default: "both"
        try_as_border = true,
      },
      symbol = "│",
      -- symbol = "▏",
    },
    config = function(_, opts)
      vim.g.miniindentscope_disable = true

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
        callback = function()
          ---@diagnostic disable-next-line
          vim.b.miniindentscope_disable = true
        end,
      })

      require("mini.indentscope").setup(opts)
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = {
      {
        "<Leader>zz",
        function()
          require("zen-mode").toggle({
            plugins = {
              twilight = {
                enabled = false,
              },
            },
          })
        end,
        silent = true,
        desc = "[Zen Mode] Toggle",
      },
      {
        "<Leader>zt",
        function()
          require("zen-mode").toggle({
            plugins = {
              twilight = {
                enabled = true,
              },
            },
          })
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
        "<Leader>tw",
        function()
          require("twilight").setup()
          require("twilight").toggle()
        end,
        silent = true,
        desc = "[Twilight] Toggle",
      },
      {
        "<Leader>tf",
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
