local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify('~ ' .. module .. ' Call Error!')
end

-- local prequire = require 'utils.prequire'
local luasnip = prequire('luasnip')
local cmp = prequire("cmp")
local icons = prequire 'core.icons'
local kind_icons = icons.kind

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    mapping = {
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      --['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "[NVIM_Lua]",
          luasnip = "[LuaSnip]",
          buffer = "[Buffer]",
          path = '[Path]',
        })[entry.source.name]
        return vim_item
      end
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim-lua' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    --sources = cmp.config.sources({
    --  { name = 'nvim_lsp' },
    --  { name = 'nvim-lua' },
    --  { name = 'luasnip' },
    --  { name = 'buffer' },
    --  { name = 'path' },
    --}),

    confirm_opts = {
      select = false,
    },

    documentation = { border = 'single' },
    --documentation = false,
    --documentation = {
    --  border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    --},

    experimental = {
      ghost_text = true,
      --native_menu = false,
    },
  })

-- TODO: VSCode like snippets (needs additional plugin)
--require("luasnip.loaders.from_vscode").lazy_load()

--vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
--vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

-- TODO: Use lspkind for icons?
--local lspkind = require('lspkind')
--cmp.setup {
--  formatting = {
--    format = lspkind.cmp_format({
--      mode = 'symbol', -- show only symbol annotations
--      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
--
--      -- The function below will be called before any actual modifications from lspkind
--      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
--      before = function (entry, vim_item)
--        ...
--        return vim_item
--      end
--    })
--  }
--}
--

-- Icons moved to core.icons
--local kind_icons = {
--  Text = "",
--  Method = "m",
--  Function = "",
--  Constructor = "",
--  Field = "",
--  Variable = "",
--  Class = "",
--  Interface = "",
--  Module = "",
--  Property = "",
--  Unit = "",
--  Value = "",
--  Enum = "",
--  Keyword = "",
--  Snippet = "",
--  Color = "",
--  File = "",
--  Reference = "",
--  Folder = "",
--  EnumMember = "",
--  Constant = "",
--  Struct = "",
--  Event = "",
--  Operator = "",
--  TypeParameter = "",
--}

