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
    opts = function()
      -- function on_click(cnt, btn, mods)
      -- params: num clicks, button, modifiers
      local onclick = {
        echo_git_branch = function()
          local branch = vim.fn.system("git branch --show-current"):gsub("%s+", "")
          vim.api.nvim_echo({ { branch, "Normal" } }, false, {})
        end,
        copy_abs_path = function()
          vim.fn.system(string.format('echo "%s" | pbcopy', vim.fn.expand("%:~")))
        end,
        echo_abs_path = function()
          vim.api.nvim_echo({ { vim.fn.expand("%:~"), "Normal" } }, false, {})
        end,
        repo_view = function()
          local ok, _ = pcall(function()
            vim.fn.system("gh repo view -w")
          end)
          return ok
        end,
      }

      local cm = {
        fmt_jira_id = function(str)
          return str:match("^%u+%-%d+")
        end,
        open_jira = function()
          local id = vim.fn.system("git branch --show-current"):match("^%u+%-%d+")
          local ok, _ = pcall(function()
            vim.ui.open(vim.fn.expand("$CM_JIRA_URL") .. id)
          end)
          return ok
        end,
      }

      return {
        options = {
          component_separators = "",
          section_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "branch",
              fmt = function(str)
                return cm.fmt_jira_id(str) or str
              end,
              on_click = function(_, btn, _)
                onclick.echo_git_branch()
                if btn == "m" then
                  return cm.open_jira() or onclick.repo_view()
                end
              end,
            },
            "diff",
            {
              "diagnostics",
              symbols = { error = " ", warn = " ", hint = " ", info = " " },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              on_click = function(_, btn, _)
                onclick.echo_abs_path()
                if btn == "r" then
                  onclick.copy_abs_path()
                end
              end,
            },
          },
          lualine_x = {
            {
              function()
                return vim.fn.getcwd():gsub(vim.fn.expand("$HOME"), "~")
              end,
            },
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
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-web-devicons" },
    event = "UIEnter",
    keys = function()
      local keymaps = {
        {
          "<Tab>",
          function()
            require("bufferline").cycle(math.max(1, vim.v.count))
          end,
          mode = { "n", "v" },
          desc = "BufferLineCyclePrev",
        },
        {
          "<S-Tab>",
          function()
            require("bufferline").cycle(math.min(-1, -vim.v.count))
          end,
          mode = { "n", "v" },
          desc = "BufferLineCyclePrev",
        },
        {
          "<Right>",
          function()
            require("bufferline").cycle(math.max(1, vim.v.count))
          end,
          mode = { "n", "v" },
          desc = "BufferLineCyclePrev",
        },
        {
          "<Left>",
          function()
            require("bufferline").cycle(math.min(-1, -vim.v.count))
          end,
          mode = { "n", "v" },
          desc = "BufferLineCyclePrev",
        },
        {
          "<Space><Right>",
          function()
            require("bufferline").move(1)
          end,
          mode = { "n", "v" },
          desc = "BufferLineMoveNext",
        },
        {
          "<Space><Left>",
          function()
            require("bufferline").move(-1)
          end,
          mode = { "n", "v" },
          desc = "BufferLineMovePrev",
        },
        {
          "<Space>p",
          function()
            require("bufferline").pick()
          end,
          mode = { "n", "v" },
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
    opts = function()
      return {
        options = {
          style_preset = 4, -- bufferline style preset no italics
          close_command = "bdelete %d",
          right_mouse_command = "bdelete %d",
          max_name_length = 30,
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
          persist_buffer_sort = true,
          move_wraps_at_ends = true,
          groups = {
            items = {
              require("bufferline.groups").builtin.pinned:with({ icon = "" }),
            },
          },
        },
      }
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
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = { enabled = false },
      messages = { enabled = false },
      popupmenu = { enabled = false },
      notify = { enabled = false },
      health = { checker = false },
      lsp = {
        progress = { enabled = false },
        message = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          -- ["cmp.entry.get_documentation"] = true,
          ["cmp.entry.get_documentation"] = false,
        },
        -- signature = {},
        documentation = {
          opts = {
            border = {
              padding = { 0, 0 },
            },
            win_options = {
              winblend = 30,
            },
          },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
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
        "<Leader>ii",
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
        animation = function(_, _)
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
        border = "top",
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
          require("zen-mode").toggle()
        end,
        silent = true,
        desc = "[Zen Mode] Toggle",
      },
      {
        "<Leader>zc",
        function()
          require("zen-mode").toggle({ window = { width = 0.5 } })
        end,
        silent = true,
        desc = "[Zen Mode] Toggle",
      },
      {
        "<Leader>zt",
        function()
          require("zen-mode").toggle({
            plugins = {
              twilight = { enabled = true },
            },
          })
        end,
        silent = true,
        desc = "[Zen Mode] Toggle with Twilight",
      },
    },
    opts = {
      window = {
        width = 1,
        height = 1,
      },
      plugins = {
        twilight = { enabled = false },
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
