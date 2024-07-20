return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "none-ls.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      },
      diagnostic = {
        underline = false,
        virtual_text = true,
        update_in_insert = true,
        severity_sort = true,
        signs = true,
        float = {
          focusable = true,
          severity_sort = true,
          source = "always",
          header = "",
          prefix = "",
          style = "minimal",
          border = "rounded",
        },
      },
      hover = {
        focusable = true,
        border = "rounded",
      },
      servers = {
        bashls = {},
        cssls = {},
        cssmodules_ls = {},
        docker_compose_language_service = {},
        dockerls = {},
        emmet_ls = {},
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
        pyright = {},
        ruff = {},
        rust_analyzer = {},
        sqlls = {},
        taplo = {},
        tsserver = {},
        yamlls = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
          end,
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
        -- mdformat = {}, -- TODO
        -- prettier = {}, -- TODO
        -- prettierd = {}, -- TODO
        -- stylua = {}, -- TODO
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      for _, sign in ipairs(opts.signs) do
        vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = "" })
      end

      vim.diagnostic.config(opts.diagnostic)

      -- TODO: need? hover and signature help don't work without, but is there another way?
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.hover)
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.hover)

      local on_init = function(client)
        client.config.flags = client.config.flags or {}
        client.config.flags.allow_incremental_sync = true
      end

      -- TODO
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true -- TODO: need ?

      for server, config in pairs(opts.servers) do
        config = vim.tbl_deep_extend("force", {
          on_init = on_init,
          capabilities = capabilities,
        }, config)

        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

          local diagnostic_goto_next, diagnostic_goto_prev =
            repeatable_move.make_repeatable_move_pair(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)

          local buf_map = function(mode, lhs, rhs, options)
            options = vim.tbl_deep_extend("force", { buffer = ev.buf }, options or {})
            vim.keymap.set(mode, lhs, rhs, options)
          end

          buf_map("n", "[d", diagnostic_goto_prev, { desc = "vim.diagnostic.goto_prev" })
          buf_map("n", "]d", diagnostic_goto_next, { desc = "vim.diagnostic.goto_next" })
          buf_map("n", "<Leader>lr", ":LspRestart<CR>", { desc = "LspRestart" })
          buf_map("n", "gl", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float" })
          buf_map("n", "gL", vim.diagnostic.setloclist, { desc = "vim.diagnostic.setloclist" })
          buf_map("n", "gh", vim.lsp.buf.hover)
          buf_map("n", "gd", vim.lsp.buf.definition)
          buf_map("n", "gD", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition" })
          buf_map("n", "<Leader>gi", vim.lsp.buf.implementation)
          buf_map("n", "gr", vim.lsp.buf.references)
          buf_map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help)
          buf_map("n", "<Leader>rn", vim.lsp.buf.rename)
          buf_map("n", "<Leader>ca", vim.lsp.buf.code_action)
          buf_map("n", "<Leader>fm", vim.lsp.buf.format)
          buf_map("n", "<Leader>Wa", vim.lsp.buf.add_workspace_folder)
          buf_map("n", "<Leader>Wr", vim.lsp.buf.remove_workspace_folder)
          buf_map("n", "<Leader>Wl", function()
            vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "notify inspect vim.lsp.buf.list_workspace_folders()" })
          buf_map("n", "<Leader>vv", function()
            vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
          end, { desc = "buf toggle virtual text" })

          local gd_cmd = function(cmd)
            local original_handler = vim.lsp.handlers["textDocument/definition"]
            vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
              if cmd ~= nil then
                vim.cmd(cmd)
              end
              original_handler(err, result, ctx, config)
              vim.api.nvim_input("zt")
              vim.lsp.handlers["textDocument/definition"] = original_handler
            end
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
            gd_cmd("tabe %")
          end, { desc = "vim.lsp.buf.definition() tabe redraw top" })
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    lazy = true,
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    opts = {
      -- TODO
      -- ensure_installed = {
      --   "bashls",
      --   "clangd",
      --   "cssls",
      --   "cssmodules_ls",
      --   "docker_compose_language_service",
      --   "dockerls",
      --   "emmet_ls",
      --   "eslint",
      --   "gopls",
      --   "html",
      --   "jsonls",
      --   "kotlin_language_server",
      --   "lua_ls",
      --   "mdformat",
      --   "prettier",
      --   "prettierd",
      --   "pyright",
      --   "ruff",
      --   "rust_analyzer",
      --   "sqlls",
      --   "stylua",
      --   "taplo",
      --   "tsserver",
      --   "yamlls",
      -- },
      automatic_installation = true,
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
        -- ruff_fix = {
        --   prepend_args = {
        --     "--ignore=F401", -- unused-import
        --   },
        -- },
        -- ruff_organize_imports = {
        --   prepend_args = {
        --     "--config=lint.isort.section-order=['future', 'standard-library', 'third-party', 'common', 'first-party', 'local-folder']",
        --     "--config=lint.isort.sections.common=['common']",
        --   },
        -- },
        -- TODO: [ERROR] Formatter 'ruff_organize_imports' error: error: `ruff <path>` has been removed. Use `ruff check <path>` instead.
        ruff_fix = {
          append_args = {
            "--ignore=F401", -- unused-import
          },
        },
        ruff_organize_imports = {
          append_args = {
            "--config=lint.isort.section-order=['future', 'standard-library', 'third-party', 'common', 'first-party', 'local-folder']",
            "--config=lint.isort.sections.common=['common']",
          },
        },
        -- stylua = {
        --   prepend_args = {
        --     "--indent-type=Spaces",
        --     "--indent-width=2",
        --   },
        -- },
      },
      formatters_by_ft = {
        go = { { "goimports", "gofmt" } },
        javascript = { { "prettier", "prettierd" } },
        javascriptreact = { { "prettier", "prettierd" } },
        json = { "fixjson" },
        lua = { "stylua" },
        markdown = { "mdformat", "prettierd" },
        -- python = { "isort", "black" },
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        toml = { "taplo" },
        typescript = { { "prettier", "prettierd" } },
        typescriptreact = { { "prettier", "prettierd" } },
        yaml = { { "prettierd", "prettier", "yamlfmt" } },
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
      -- "nvim-treesitter/nvim-treesitter", -- TODO
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
        width = 0.7,
        keys = {
          edit = "<Leader>we",
          vsplit = "<Leader>wv",
          split = "<Leader>ws",
          tabe = "<Leader>wt",
          quit = "q",
        },
      },
      finder = {
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
    opts = {
      modes_denylist = { "v" },
    },
    config = function(_, opts)
      local illuminate = require("illuminate")
      local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

      local goto_next_ref, goto_prev_ref =
        repeatable_move.make_repeatable_move_pair(illuminate.goto_next_reference, illuminate.goto_prev_reference)

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

      illuminate.configure(opts)

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
  { -- TODO
    "folke/lazydev.nvim",
    lazy = true,
    ft = "lua",
    opts = {},
  },
  -- TODO
  -- {
  --   "folke/lazydev.nvim",
  --   ft = "lua", -- only load on lua files
  --   opts = {
  --     library = {
  --       -- See the configuration section for more details
  --       -- Load luvit types when the `vim.uv` word is found
  --       { path = "luvit-meta/library", words = { "vim%.uv" } },
  --     },
  --   },
  -- },
  -- { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  -- { -- optional completion source for require statements and module annotations
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, {
  --       name = "lazydev",
  --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --     })
  --   end,
  -- },
  -- -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
