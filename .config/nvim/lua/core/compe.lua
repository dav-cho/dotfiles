----------------------------- nvim compe -----------------------------

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    ---- the border option is the same as `|help nvim_open_win|`
    border = { '', '' ,'', ' ', '', '', '', ' ' },
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

-------------------------------- Maps --------------------------------

local map_compe = function(before, after, opts)
  local options = { noremap = true, expr = true, silent = true }
  local lhs = string.format('<silent><expr> %s', before)
  local rhs = string.format('compe#%s', after)

  if opts then options = opts end

  vim.api.nvim_set_keymap('i', lhs, rhs, options)
end

map_compe('<C-Space>', 'complete()')
map_compe('<CR>', 'confirm("<CR>")')
map_compe('<C-e>', 'close("<C-e>")')
map_compe('<C-f>', 'scroll({ "delta": +4 })')
map_compe('<C-d>', 'scroll({ "delta": -4 })')

--------------------------- Tab Navigation ---------------------------

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  else
    return t "<Tab>"
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

---- Use (s-)tab to:
----- move to prev/next item in completion menuone
----- jump to prev/next snippet's placeholder
--_G.tab_complete = function()
--  if vim.fn.pumvisible() == 1 then
--    return t "<C-n>"
--  elseif vim.fn['vsnip#available'](1) == 1 then
--    return t "<Plug>(vsnip-expand-or-jump)"
--  elseif check_back_space() then
--    return t "<Tab>"
--  else
--    return vim.fn['compe#complete']()
--  end
--end
--_G.s_tab_complete = function()
--  if vim.fn.pumvisible() == 1 then
--    return t "<C-p>"
--  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
--    return t "<Plug>(vsnip-jump-prev)"
--  else
--    -- If <S-Tab> is not working in your terminal, change it to <C-h>
--    return t "<S-Tab>"
--  end
--end

local map_compe_tab = function(mode, before, after, opts)
  local options = { expr = true }
  local rhs = string.format('v:lua.%s()', after)

  vim.api.nvim_set_keymap(mode, before, rhs, options)
end

map_compe_tab('i', '<Tab>', 'tab_complete')
map_compe_tab('s', '<Tab>', 'tab_complete')
map_compe_tab('i', '<S-Tab>', 's_tab_complete')
map_compe_tab('s', '<S-Tab>', 's_tab_complete')

----------------------------------------------------------------------

