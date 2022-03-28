local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify('~ ' .. module .. ' Call Error!')
end

--local prequire = require 'utils.prequire'
local npairs = prequire 'nvim-autopairs'

npairs.setup {
  check_ts = true,

  -- ts_config = {
    --   lua = { 'string' }, -- it will not add a pair on that treesitter node
    --   javascript = { 'template_string' },
    --   java = false, -- don't check treesitter on java
    -- },

  disable_filetype = { 'TelescopePrompt' },
}

local ts_conds = prequire 'nvim-autopairs.ts-conds'

-- If you want insert `(` after select function or method item
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = prequire 'cmp'

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

