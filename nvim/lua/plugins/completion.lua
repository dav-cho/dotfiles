return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-calc",
    },
    opts = function()
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local keymap = {
        preset = "none",

        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.insert_next()
              return true
            elseif luasnip.locally_jumpable(1) then
              cmp.snippet_forward()
              return true
            elseif has_words_before() then
              cmp.show()
              return true
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          "snippet_backward",
          "insert_prev",
          "fallback",
        },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-_>"] = { "show", "cancel", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<M-?>"] = { "hide_documentation", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      }

      for i = 1, 9 do
        keymap[("<M-%d>"):format(i)] = {
          function(cmp)
            cmp.accept({ index = i, "fallback" })
          end,
        }
      end

      vim.b.blink_enabled = true
      vim.g.blink_enabled = true

      vim.keymap.set("n", "<Leader>tc", function()
        vim.b.blink_enabled = not (vim.b.blink_enabled ~= false)
      end, { desc = "[blink.cmp] Toggle local `vim.b.blink_enabled`" })
      vim.keymap.set("n", "<Leader>TC", function()
        vim.g.blink_enabled = not vim.g.blink_enabled
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_set_var(buf, "blink_enabled", vim.g.blink_enabled)
          end
        end
      end, { desc = "[blink.cmp] Toggle global `vim.g.blink_enabled`" })

      return {
        keymap = keymap,
        enabled = function()
          if vim.b.blink_enabled == nil then
            vim.b.blink_enabled = vim.g.blink_enabled
          end
          return vim.b.blink_enabled and vim.g.blink_enabled
        end,
        completion = {
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            window = {
              border = "single",
              winblend = 10,
            },
          },
          keyword = {
            range = "full",
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          menu = {
            draw = {
              columns = {
                { "label" },
                { "kind_icon", "kind", gap = 1 },
                { "label_description" },
              },
              components = {
                label_description = {
                  highlight = "NormalFloat",
                },
              },
            },
            winblend = 10,
          },
          trigger = {
            prefetch_on_insert = false,
            show_on_blocked_trigger_characters = function(_)
              if vim.bo.filetype == "python" then
                return { " ", "\n", "\t", ":" }
              end
              return { " ", "\n", "\t" }
            end,
          },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lsp", "snippets", "buffer", "path", "calc" },
          providers = {
            calc = {
              name = "calc",
              module = "blink.compat.source",
            },
          },
        },
        fuzzy = {
          sorts = {
            "exact",
            "score",
            "sort_text",
          },
        },
        cmdline = {
          completion = {
            list = {
              selection = {
                preselect = false,
                auto_insert = false,
              },
            },
            menu = { auto_show = true },
          },
          keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
            ["<Tab>"] = { "show", "insert_next", "fallback" },
            ["<S-Tab>"] = { "show", "insert_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
          },
        },
      }
    end,
    opts_extend = { "sources.default" },
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      local luasnip = require("luasnip")
      luasnip.filetype_extend("javascriptreact", { "javascript" })
      luasnip.filetype_extend("typescriptreact", { "typescript" })
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "~/dotfiles/nvim/snippets" },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    dependencies = {
      "nvim-cmp",
    },
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.setup(opts)

      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      npairs.add_rules({
        Rule(" ", " ")
          :with_pair(function(_opts)
            local pair = _opts.line:sub(_opts.col - 1, _opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2],
            }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(_opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = _opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
              brackets[1][1] .. "  " .. brackets[1][2],
              brackets[2][1] .. "  " .. brackets[2][2],
              brackets[3][1] .. "  " .. brackets[3][2],
            }, context)
          end),
      })
      for _, bracket in pairs(brackets) do
        npairs.add_rules({
          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(_opts)
              return _opts.char == bracket[2]
            end)
            :with_del(cond.none())
            :use_key(bracket[2])
            :replace_map_cr(function(_)
              return "<C-c>2xi<CR><C-c>O"
            end),
        })
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
      { "hrsh7th/cmp-cmdline", lazy = true },
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "hrsh7th/cmp-nvim-lsp-document-symbol", lazy = true },
      { "hrsh7th/cmp-nvim-lua", lazy = true },
      { "hrsh7th/cmp-calc", lazy = true }, -- TODO
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
          { name = "nvim_lsp_document_symbol" },
        },
      })

      return {
        performance = {
          fetching_timeout = 100,
        },
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            scrolloff = 1,
          },
          documentation = {
            border = "single",
          },
        },
        mapping = {
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true })),
          ["<M-CR>"] = cmp.mapping(
            cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            { "i", "c" }
          ),
          ["<C-_>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end, { "i", "c" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            -- https://github.com/onsails/lspkind.nvim/blob/master/lua/lspkind/init.lua
            local kind_icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            }
            local menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
            }

            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = (
              vim_item.menu == nil and (menu[entry.source.name] == nil and "" or menu[entry.source.name])
            ) or vim_item.menu

            return vim_item
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lua" },
        }, {
          { name = "buffer" },
          { name = "path" },
          { name = "calc" },
        }),
      }
    end,
  },
}
