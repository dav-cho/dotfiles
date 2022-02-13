--------------------------- nvim-autopairs ---------------------------

-- TODO: not working....
require("nvim-autopairs.completion.compe").setup({
  ---- map <CR> on insert mode
  --map_cr = true,
  ---- it will auto insert `(` after select function or method item
  map_complete = true
})

--require('nvim-autopairs').setup()

--require('nvim-autopairs').setup({
--  disable_filetype = { "TelescopePrompt" },
--  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
--  enable_moveright = true,
--  enable_afterquote = true,
--  enable_check_bracket_line = true,
--  check_ts = false,
--})

----------------------- treesitter check pairs -----------------------

--local npairs = require("nvim-autopairs")
--
--npairs.setup({
--    check_ts = true,
--    ts_config = {
--        lua = {'string'},-- it will not add pair on that treesitter node
--        javascript = {'template_string'},
--        java = false,-- don't check treesitter on java
--    }
--})
--
--require('nvim-treesitter.configs').setup {
--    autopairs = {enable = true}
--}
--
--local ts_conds = require('nvim-autopairs.ts-conds')
--
--
---- press % => %% is only inside comment or string
--npairs.add_rules({
--  Rule("%", "%", "lua")
--    :with_pair(ts_conds.is_ts_node({'string','comment'})),
--  Rule("$", "$", "lua")
--    :with_pair(ts_conds.is_not_ts_node({'function'}))
--})

----------------------------------------------------------------------

