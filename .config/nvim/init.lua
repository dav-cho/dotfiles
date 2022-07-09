-- Globals that should always be visible.
-- require "dav.globals" -- TODO

-- TODO: Move to plugins.lua?
if require "dav.first_load"() then
	return
end

vim.g.mapleader = ","

-- require "dav.disable_builtin" -- TODO
require "dav.plugins" -- TODO: need? way to autoload?
require "dav.themes" -- TODO
require "dav.lsp" -- TODO
require "dav.telescope" -- TODO
