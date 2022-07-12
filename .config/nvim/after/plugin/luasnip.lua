local ok, ls = pcall(require, "luasnip")
if not ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load {
  paths = "~/Library/Application Support/Code/User/snippets"
}

ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "typescript" })



-- TODO: Add snippets

-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
-- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/dav/snippets/ft/*.lua", true)) do
--   loadfile(ft_path)()
-- end


-- TODO
-- local ls = require "luasnip"
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local m = require("luasnip.extras").m
-- local lambda = require("luasnip.extras").l
-- local postfix = require("luasnip.extras.postfix").postfix
