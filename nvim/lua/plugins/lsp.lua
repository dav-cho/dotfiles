return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
      "folke/neodev.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      },
      diagnostic = {
        underline = false,
        virtual_text = false,
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
        rust_analyzer = {},
        sqlls = {},
        tsserver = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

      local diagnostic_goto_next, diagnostic_goto_prev = repeatable_move.make_repeatable_move_pair(
        vim.diagnostic.goto_next, vim.diagnostic.goto_prev
      )

      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float" })
      vim.keymap.set("n", "gL", vim.diagnostic.setloclist, { desc = "vim.diagnostic.setloclist" })
      vim.keymap.set("n", "[d", diagnostic_goto_prev, { desc = "vim.diagnostic.goto_prev" })
      vim.keymap.set("n", "]d", diagnostic_goto_next, { desc = "vim.diagnostic.goto_next" })
      vim.keymap.set("n", "<leader>lr", function() vim.cmd("LspRestart") end, { desc = "LspRestart" })

      for _, sign in ipairs(opts.signs) do
        vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = "" })
      end

      vim.diagnostic.config(opts.diagnostic)

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.hover)
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.hover)

      local on_init = function(client)
        client.config.flags = client.config.flags or {}
        client.config.flags.allow_incremental_sync = true
      end

      local on_attach = function(_, bufnr)
        local buf_map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr })
        end

        buf_map("n", "gh", vim.lsp.buf.hover)
        buf_map("n", "gd", vim.lsp.buf.definition)
        buf_map("n", "gD", vim.lsp.buf.type_definition)
        buf_map("n", "gi", vim.lsp.buf.implementation)
        buf_map("n", "gr", vim.lsp.buf.references)
        buf_map({ "n", "i" }, "<M-s>", vim.lsp.buf.signature_help)
        buf_map("n", "<leader>gd", vim.lsp.buf.declaration)
        buf_map("n", "<leader>rn", vim.lsp.buf.rename)
        buf_map("n", "<leader>ca", vim.lsp.buf.code_action)
        buf_map("n", "<leader>Wa", vim.lsp.buf.add_workspace_folder)
        buf_map("n", "<leader>Wr", vim.lsp.buf.remove_workspace_folder)
        buf_map("n", "<leader>Wl", function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      for server, config in pairs(opts.servers) do
        config = vim.tbl_deep_extend("force", {
          on_init = on_init,
          on_attach = on_attach,
          capabilities = capabilities,
        }, config)

        lspconfig[server].setup(config)
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    lazy = true,
    cmd = "Mason",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    opts = {
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
          code_actions.eslint,
          code_actions.gitsigns,
          diagnostics.zsh,
        }
      })

      local toggle_pylint_diagnostics = function()
        if nls.is_registered("pylint") then
          nls.toggle("pylint")
        else
          nls.register(diagnostics.pylint.with({
            diagnostic_config = {
              virtual_text = { prefix = "", spacing = 2 },
            }
          }))
        end
      end

      vim.keymap.set("n", "<leader>pl", toggle_pylint_diagnostics, { silent = true, desc = "Toggle pylint diagnostics" })
    end,
  },
  { "folke/neodev.nvim", lazy = true, config = true },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<Space>\\",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = { "n", "x" },
        desc = "[Conform] Format"
      },
      { "<leader>ci", "<Cmd>ConformInfo<CR>", desc = "[Conform] Info" },
    },
    opts = {
      formatters_by_ft = {
        go = { { "goimports", "gofmt" } },
        javascript = { { "prettierd", "prettier" } },
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        typescript = { { "prettierd", "prettier" } },
        yaml = { { "prettier", "yamlfmt" } },
        ["_"] = { "trim_whitespace" },
      },
    },
    config = function(_, opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      require("conform").setup(opts)

      require("conform.formatters.goimports").command = vim.fn.expand("$HOME/go/bin/goimports")
      require("conform.formatters.isort").args = {
        "--stdout", "--filename", "$FILENAME", "--profile", "black", "-",
      }
      require("conform.formatters.prettier").args = {
        "--stdin-filepath", "$FILENAME", "--config-precedence", "prefer-file", "--single-quote",
      }
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LspAttach",
    keys = function()
      local keymaps = {
        { "<leader>lf", "<Cmd>Lspsaga finder<CR>",                     desc = "lsp_finder" },
        { "<F2>",       "<Cmd>Lspsaga rename<CR>",                     desc = "rename" },
        { "<Space>d",   "<Cmd>Lspsaga peek_definition<CR>",            desc = "peek_definition" },
        { "<Space>t",   "<Cmd>Lspsaga peek_type_definition<CR>",       desc = "peek_type_definition" },
        { "<leader>sl", "<Cmd>Lspsaga show_line_diagnostics<CR>",      desc = "show_line_diagnostics" },
        { "<leader>sb", "<Cmd>Lspsaga show_buf_diagnostics<CR>",       desc = "show_buf_diagnostics" },
        { "<leader>sw", "<Cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "show_workspace_diagnostics" },
        { "<leader>sc", "<Cmd>Lspsaga show_cursor_diagnostics<CR>",    desc = "show_cursor_diagnostics" },
        { "<leader>so", "<Cmd>Lspsaga outline<CR>",                    desc = "outline" },
        { "<leader>gh", "<Cmd>Lspsaga hover_doc<CR>",                  desc = "hover_doc" },
        { "<leader>in", "<Cmd>Lspsaga incoming_calls<CR>",             desc = "incoming_calls" },
        { "<leader>ou", "<Cmd>Lspsaga outgoing_calls<CR>",             desc = "outgoing_calls" },
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
          edit = "<leader>we",
          vsplit = "<leader>wv",
          split = "<leader>ws",
          tabe = "<leader>wt",
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

      local goto_next_ref, goto_prev_ref = repeatable_move.make_repeatable_move_pair(
        illuminate.goto_next_reference, illuminate.goto_prev_reference
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

      illuminate.configure(opts)
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      window = {
        relative = "editor",
      },
    },
    config = true,
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>sy", "<cmd>SymbolsOutline<CR>", silent = true, desc = "[SymbolsOutline] Toggle" },
    },
    opts = {
      position = "left",
      relative_width = false,
      width = 40,
      keymaps = {
        hover_symbol = "gh",
        fold = "zc",
        unfold = "zo",
        fold_all = "zM",
        unfold_all = "zR",
      },
    },
  },
}
