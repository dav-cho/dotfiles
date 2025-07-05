return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "none-ls.nvim",
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      vim.diagnostic.config({
        underline = false,
        virtual_text = false,
        update_in_insert = true,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        float = {
          focusable = true,
          severity_sort = true,
          source = "always",
          header = "",
          prefix = "",
          style = "minimal",
          border = "rounded",
        },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        bashls = {},
        cssls = {},
        cssmodules_ls = {},
        docker_compose_language_service = {},
        dockerls = {},
        eslint = {},
        gopls = {},
        html = {},
        jsonls = {},
        kotlin_language_server = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  "vim",
                  "require",
                },
              },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              pythonPath = (function()
                local venv_active = os.getenv("VIRTUAL_ENV")
                local venv_local_path = vim.fn.exepath("./.venv/bin/python")
                return (venv_active and venv_active .. "/bin/python")
                  or (#venv_local_path > 0 and venv_local_path)
                  or nil
              end)(),
            },
          },
        },
        ruff = {},
        rust_analyzer = {},
        sqlls = {},
        taplo = {},
        ts_ls = {},
        yamlls = {
          settings = {
            yaml = {
              format = {
                bracketSpacing = false,
              },
              customTags = {
                "{{.*}}",
              },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, config))
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local buf_map = function(mode, lhs, rhs, options)
            options = vim.tbl_deep_extend("force", { buffer = ev.buf }, options or {})
            vim.keymap.set(mode, lhs, rhs, options)
          end

          local diagnostic_goto_next, diagnostic_goto_prev = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
            function()
              vim.diagnostic.jump({ count = 1, float = true })
            end,
            function()
              vim.diagnostic.jump({ count = -1, float = true })
            end
          )

          buf_map("n", "<Leader>td", function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          end, { desc = "toggle diagnostics" })
          buf_map("n", "[d", diagnostic_goto_prev, { desc = "vim.diagnostic.goto_prev" })
          buf_map("n", "]d", diagnostic_goto_next, { desc = "vim.diagnostic.goto_next" })
          buf_map("n", "<Leader>lr", ":LspRestart<CR>", { desc = "LspRestart" })
          buf_map("n", "gl", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float" })
          buf_map("n", "gh", function()
            vim.lsp.buf.hover({ focusable = true, border = "rounded" })
          end, { desc = "vim.lsp.buf.hover" })
          buf_map("n", "gd", vim.lsp.buf.definition)
          buf_map("n", "gD", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition" })
          buf_map("n", "<Leader>gi", vim.lsp.buf.implementation)
          buf_map("n", "gr", vim.lsp.buf.references)
          buf_map({ "n", "i" }, "<M-s>", function()
            vim.lsp.buf.signature_help({ focusable = true, border = "rounded" })
          end, { desc = "vim.lsp.buf.signature_help" })
          buf_map("n", "<Leader>rn", vim.lsp.buf.rename)
          buf_map("n", "<Leader>ca", vim.lsp.buf.code_action)
          buf_map("n", "<Leader>FM", vim.lsp.buf.format)
          buf_map("n", "<Leader>Wa", vim.lsp.buf.add_workspace_folder)
          buf_map("n", "<Leader>Wr", vim.lsp.buf.remove_workspace_folder)
          buf_map("n", "<Leader>Wl", function()
            vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "notify inspect vim.lsp.buf.list_workspace_folders()" })
          buf_map("n", "<Leader>vv", function()
            vim.diagnostic.config({ virtual_text = not vim.diagnostic.config()["virtual_text"] })
          end, { desc = "buf toggle virtual text" })

          local gd_cmd = function(cmd)
            vim.cmd(cmd)
            vim.lsp.buf.definition()
          end

          buf_map("n", "<Leader>gd", function()
            gd_cmd()
          end, { desc = "vim.lsp.buf.definition() redraw top" })
          buf_map("n", "<Leader>gv", function()
            gd_cmd("wincmd v")
          end, { desc = "vim.lsp.buf.definition() vsplit redraw top" })
          buf_map("n", "<Leader>gx", function()
            gd_cmd("wincmd s")
          end, { desc = "vim.lsp.buf.definition() split redraw top" })
          buf_map("n", "<Leader>gt", function()
            gd_cmd("tab split")
          end, { desc = "vim.lsp.buf.definition() tab split redraw top" })

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client == nil then
            return
          end

          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          if client.name == "yamlls" then
            client.server_capabilities.documentFormattingProvider = true
          end
        end,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    lazy = true,
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    opts = {
      ensure_installed = {
        "bashls",
        "docker_compose_language_service",
        "dockerls",
        "jsonls",
        "kotlin_language_server",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "taplo",
        "ts_ls",
        "yamlls",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    config = function()
      local nls = require("null-ls")
      local diagnostics = nls.builtins.diagnostics
      local code_actions = nls.builtins.code_actions

      nls.setup({
        update_in_insert = true,
        sources = {
          code_actions.gitsigns,
          diagnostics.zsh,
        },
      })

      vim.keymap.set("n", "<Leader>pl", function()
        if nls.is_registered("pylint") then
          nls.toggle("pylint")
        else
          nls.register(diagnostics.pylint.with({
            diagnostic_config = {
              virtual_text = { prefix = "", spacing = 2 },
            },
          }))
        end
      end, { silent = true, desc = "Toggle pylint diagnostics" })

      vim.keymap.set("n", "<Leader>mt", function()
        if nls.is_registered("mypy") then
          nls.toggle("mypy")
        else
          nls.register(diagnostics.mypy)
        end
      end, { silent = true, desc = "Toggle mypy diagnostics" })
    end,
  },
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
      {
        "<Space>\\",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "[Conform] Format",
      },
      { "<Leader>ci", "<Cmd>ConformInfo<CR>", desc = "[Conform] Info" },
      "gq",
    },
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        goimports = {
          command = vim.fn.expand("$HOME/go/bin/goimports"),
        },
        isort = {
          prepend_args = {
            "--profile=black",
            "--lines-before-imports=1",
            "--lines-after-imports=1",
            "--treat-all-comment-as-code",
            "--float-to-top",
          },
        },
        prettier = {
          prepend_args = {
            "--config-precedence",
            "prefer-file",
            "--single-quote",
          },
        },
        ruff_fix = {
          append_args = {
            "--ignore=F401", -- unused-import
          },
        },
        ruff_organize_imports = {
          append_args = {
            "--config=lint.isort.section-order=['future', 'standard-library', 'third-party', 'common', 'first-party', 'local-folder']",
            "--config=lint.isort.sections.common=['common']",
            "--config=lint.isort.split-on-trailing-comma=false",
          },
        },
      },
      formatters_by_ft = {
        go = { "goimports", "gofmt", stop_after_first = true },
        javascript = { "prettier", "prettierd", stop_after_first = true },
        javascriptreact = { "prettier", "prettierd", stop_after_first = true },
        json = { "fixjson" },
        lua = { "stylua" },
        markdown = { "mdformat", "prettierd" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        toml = { "taplo" },
        typescript = { "prettier", "prettierd", stop_after_first = true },
        typescriptreact = { "prettier", "prettierd", stop_after_first = true },
        yaml = { "prettierd", "prettier", "yamlfmt", stop_after_first = true },
        ["_"] = { "trim_whitespace" },
      },
    },
    config = function(_, opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      require("conform").setup(opts)
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "LspAttach",
    keys = function()
      local keymaps = {
        { "<Leader>lf", "<Cmd>Lspsaga finder<CR>", desc = "lsp_finder" },
        { "<F2>", "<Cmd>Lspsaga rename<CR>", desc = "rename" },
        { "<Space>d", "<Cmd>Lspsaga peek_definition<CR>", desc = "peek_definition" },
        { "<Space>t", "<Cmd>Lspsaga peek_type_definition<CR>", desc = "peek_type_definition" },
        { "<Leader>sl", "<Cmd>Lspsaga show_line_diagnostics<CR>", desc = "show_line_diagnostics" },
        { "<Leader>sb", "<Cmd>Lspsaga show_buf_diagnostics<CR>", desc = "show_buf_diagnostics" },
        { "<Leader>sw", "<Cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "show_workspace_diagnostics" },
        { "<Leader>sc", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "show_cursor_diagnostics" },
        { "<Leader>so", "<Cmd>Lspsaga outline<CR>", desc = "outline" },
        { "<Leader>sr", "<Cmd>Lspsaga finder<CR>", desc = "finder" },
        { "<Leader>gh", "<Cmd>Lspsaga hover_doc<CR>", desc = "hover_doc" },
        { "<Leader>in", "<Cmd>Lspsaga incoming_calls<CR>", desc = "incoming_calls" },
        { "<Leader>ou", "<Cmd>Lspsaga outgoing_calls<CR>", desc = "outgoing_calls" },
      }

      for _, keymap in pairs(keymaps) do
        keymap.desc = "[Lspsaga] " .. (keymap.desc or "")
      end

      return keymaps
    end,
    opts = {
      beacon = {
        enable = false,
      },
      definition = {
        width = 1,
        keys = {
          edit = "<Leader>we",
          vsplit = "<Leader>wv",
          split = "<Leader>ws",
          tabe = "<Leader>wt",
          quit = "q",
        },
      },
      finder = {
        max_height = 0.8,
        keys = {
          split = "x",
        },
      },
      lightbulb = {
        enable = false,
      },
      outline = {
        layout = "float",
        max_height = 0.9,
      },
      rename = {
        in_select = false,
        keys = {
          quit = "<C-c>",
        },
      },
      symbol_in_winbar = {
        separator = "  ",
      },
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "LspAttach",
    config = function(_, opts)
      local goto_next_ref, goto_prev_ref = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
        function()
          require("illuminate").goto_next_reference()
        end,
        function()
          require("illuminate").goto_prev_reference()
        end
      )

      vim.keymap.set(
        { "n", "x", "o" },
        "<M-n>",
        goto_next_ref,
        { silent = true, desc = "[Illuminate] Move to next reference" }
      )
      vim.keymap.set(
        { "n", "x", "o" },
        "<M-p>",
        goto_prev_ref,
        { silent = true, desc = "[Illuminate] Move to previous reference" }
      )

      require("illuminate").configure(opts)

      local highlight_overrides = {
        "IlluminatedWordText",
        "IlluminatedWordRead",
        "IlluminatedWordWrite",
      }
      for _, highlight in ipairs(highlight_overrides) do
        vim.cmd("highlight " .. highlight .. " gui=none")
      end
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
      panel = {
        keymap = {
          open = "<M-L>",
        },
      },
      suggestion = {
        auto_trigger = true,
      },
      should_attach = function(_, _)
        local logger = require("copilot.logger")

        if not vim.bo.buflisted then
          logger.debug("not attaching, buffer is not 'buflisted'")
          return false
        end

        if vim.bo.buftype ~= "" then
          logger.debug("not attaching, buffer 'buftype' is " .. vim.bo.buftype)
          return false
        end

        return true
      end,
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspNotify",
    keys = {
      {
        "<Leader>nh",
        function()
          require("fidget.notification").show_history()
        end,
        desc = ":Fidget history",
      },
      {
        "<Leader>fx",
        function()
          require("fidget.notification").clear()
        end,
        desc = ":Fidget clear",
      },
    },
    opts = {
      integration = {
        ["nvim-tree"] = { enable = false },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    lazy = true,
    ft = "lua",
    opts = {},
  },
}
