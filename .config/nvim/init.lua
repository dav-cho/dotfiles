-- Globals that should always be visible.
-- TODO
-- require "dav.globals"

-- TODO
if require "dav.first_load"() then
	return
end

vim.g.mapleader = ","

-- TODO
-- require "dav.disable_builtin"

-- require "dav.lsp"
require "dav.telescope"
require "dav.plugins" -- need?
require "dav.themes"
