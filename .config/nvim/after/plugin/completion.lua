vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- TODO: config added sources: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

-- TODO
-- vim.opt.shortmess:append "c"

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local has_lspkind, lspkind = pcall(require, "lspkind")
if not has_lspkind then
  return
end

-- lspkind.init()
lspkind.init {
  symbol_map = {
    TypeParameter = "",
  },
}

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup {
  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    -- ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    -- ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- ["<C-j>"] = cmp.mapping.select_next_item(),

    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },

    -- TODO: docs on command line?
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(4),

    ["<C-Space>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end, { "i", "c" }),

    -- TODO
    -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ["<C-y>"] = cmp.config.disable,

    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- ["<CR>"] = cmp.mapping.confirm({ select = false }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  -- Using lspkind:
  formatting = {
    fields = { "kind", "abbr", "menu" },

    -- format = lspkind.cmp_format(),
    format = lspkind.cmp_format {
      -- defines how annotations are shown
      -- default: symbol
      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      mode = "symbol",

      menu = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        -- gh_issues = "[Issues]", -- TODO
      },
    },
  },
  -- TODO: Use both lspkind and kind_icons
  -- formatting = {
  --   fields = { "kind", "abbr", "menu" },
  --
  --   format = function(entry, vim_item)
  --     -- TODO
  --     -- local menu_config = {
  --     --   buffer = "[Buf]",
  --     --   nvim_lsp = "[LSP]",
  --     --   luasnip = "[LuaSnip]",
  --     --   nvim_lua = "[Lua]",
  --     --   path = "[Path]",
  --     --   -- gh_issues = "[Issues]", -- TODO
  --     -- }
  --
  --     if has_lspkind then
  --       return lspkind.cmp_format {
  --         mode = "symbol",
  --
  --         menu = {
  --           buffer = "[Buf]",
  --           nvim_lsp = "[LSP]",
  --           luasnip = "[LuaSnip]",
  --           nvim_lua = "[Lua]",
  --           path = "[Path]",
  --           -- gh_issues = "[Issues]", -- TODO
  --         },
  --       }
  --     else
  --       -- Kind icons
  --       -- This concatonates the icons with the name of the item kind
  --       -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
  --       -- Without text (icons only)
  --       -- vim_item.kind = kind_icons[vim_item.kind]
  --       -- vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
  --
  --       -- Source
  --       -- vim.item.menu = menu_config[entry.source.name] -- TODO
  --       vim_item.menu = ({
  --         buffer = "[Buf]",
  --         path = "[Path]",
  --         nvim_lsp = "[LSP]",
  --         luasnip = "[LuaSnip]",
  --         nvim_lua = "[Lua]",
  --         -- gh_issues = "[Issues]", -- TODO
  --         latex_symbols = "[LaTeX]",
  --       })[entry.source.name]
  --
  --       return vim_item
  --     end
  --   end,
  -- },
  -- OLD: Without lspkind
  -- formatting = {
  --   fields = { "kind", "abbr", "menu" },
  --   format = function(entry, vim_item)
  --     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
  --     vim_item.menu = ({
  --       luasnip = "[LuaSnip]",
  --       nvim_lsp = "[LSP]",
  --       nvim_lua = "[NVIM_Lua]",
  --       buffer = "[Buffer]",
  --       path = "[Path]",
  --     })[entry.source.name]
  --     return vim_item
  --   end
  -- },
  -- From nvim-cmp:
  -- formatting = {
  --   format = function(entry, vim_item)
  --     -- Kind icons
  --     -- This concatonates the icons with the name of the item kind
  --     vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
  --     -- Source
  --     vim_item.menu = ({
  --       buffer = "[Buffer]",
  --       nvim_lsp = "[LSP]",
  --       luasnip = "[LuaSnip]",
  --       nvim_lua = "[Lua]",
  --       latex_symbols = "[LaTeX]",
  --     })[entry.source.name]
  --     return vim_item
  --   end
  -- },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    -- { name = "nvim-lua" },
    { name = "luasnip" },
    -- { name = "gh_issues" }, -- TODO
  }, {
    { name = "buffer" },
    { name = "path" },
  }),

  -- TODO: from old setup but not sure if it's valid options
  -- confirm_opts = {
  --   select = false,
  -- },

  window = {
    documentation = { border = "single" },
  },

  -- experimental = {
  --   ghost_text = true,
  --   --native_menu = false,
  -- },
}

-- TODO: goes in cmp.setup
-- sorting = {
--   comparators = {
--     cmp.config.compare.offset,
--     cmp.config.compare.exact,
--     cmp.config.compare.score,
--
--     -- copied from cmp-under, but I don't think I need the plugin for this.
--     -- I might add some more of my own.
--     function(entry1, entry2)
--       local _, entry1_under = entry1.completion_item.label:find "^_+"
--       local _, entry2_under = entry2.completion_item.label:find "^_+"
--       entry1_under = entry1_under or 0
--       entry2_under = entry2_under or 0
--       if entry1_under > entry2_under then
--         return false
--       elseif entry1_under < entry2_under then
--         return true
--       end
--     end,
--
--     cmp.config.compare.kind,
--     cmp.config.compare.sort_text,
--     cmp.config.compare.length,
--     cmp.config.compare.order,
--   },
-- },



-- TODO: Additional icons - use if not using lspkind
--
-- -- LunarVim icons:
-- local kind_icons = {
--   Text = "",
--   Method = "m",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "",
--   Interface = "",
--   Module = "",
--   Property = "",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = "",
-- }
--
-- -- Default lspkind icons:
-- local kind_icons = {
--   Text = "",
--   Method = "",
--   Function = "",
--   Constructor = "",
--   Field = "ﰠ",
--   Variable = "",
--   Class = "ﴯ",
--   Interface = "",
--   Module = "",
--   Property = "ﰠ",
--   Unit = "塞",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "פּ",
--   Event = "",
--   Operator = "",
--   TypeParameter = ""
-- }
--
-- -- Icons from nvim-cmp docs:
-- local kind_icons = {
--   Text = "",
--   Method = "",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "ﴯ",
--   Interface = "",
--   Module = "",
--   Property = "ﰠ",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = ""
-- }
