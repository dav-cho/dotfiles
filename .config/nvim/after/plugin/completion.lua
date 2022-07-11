vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- TODO
-- vim.opt.shortmess:append "c"

-- local function prequire(module_name)
--   local ok, module = pcall(require, module_name)
--   if ok then
--     return module
--   end
-- end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

-- TODO
-- lspkind.init()
-- lspkind.init {
--   mode = "symbol_text", -- "text", "text_symbol", "symbol-tet", "symbol"
--   preset = "default", -- "codicons"
--   symbol_map = {
--
--   },
-- }
--
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

local cmp = require("cmp")

cmp.setup {
  -- preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },

    -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    ["<C-Space>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end, { "i", "c" }),
    -- ["<c-space>"] = cmp.mapping {
    --   i = cmp.mapping.complete(),
    --   c = function(
    --     _ --[[fallback]]
    --   )
    --     if cmp.visible() then
    --       if not cmp.confirm { select = true } then
    --         return
    --       end
    --     else
    --       cmp.complete()
    --     end
    --   end,
    -- },

    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- cmp.select_next_item()
        cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
        -- TODO: uncomment after setup luasnip
        -- elseif luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- cmp.select_prev_item()
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
        -- TODO: uncomment after setup luasnip
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

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
  -- formatting = {
  --   -- Youtube: How to set up nice formatting for your sources.
  --   format = lspkind.cmp_format {
  --     with_text = true,
  --     menu = {
  --       buffer = "[buf]",
  --       nvim_lsp = "[LSP]",
  --       nvim_lua = "[api]",
  --       path = "[path]",
  --       luasnip = "[snip]",
  --       gh_issues = "[issues]",
  --       tn = "[TabNine]",
  --     },
  --   },
  -- },
  -- Default:
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(_, vim_item)
      return vim_item
    end,
  },

  -- sorting = {
  --   -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
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

  -- sources = cmp.config.sources({
  --   { name = 'nvim_lsp' },
  --   { name = 'nvim-lua' },
  --   { name = 'luasnip' },
  -- }, {
  --   { name = 'buffer' },
  --   { name = 'path' },
  -- }),
  -- Default:
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  },

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



-- Recommended
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--     end,
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' }, -- For luasnip users.
--   }, {
--     { name = 'buffer' },
--   })
-- }
