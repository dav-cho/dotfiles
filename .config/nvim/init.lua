-- TODO
-- Globals that should always be visible.
-- require "dav.globals"

-- TODO: Move to plugins.lua?
if require "dav.first_load"() then
	return
end

vim.g.mapleader = ","
-- vim.g.maplocalleader = ',' -- TODO: need?

-- require "dav.disable_builtin" -- TODO
require "dav.plugins"
require "dav.themes" -- TODO
require "dav.lsp"
require "dav.telescope"
