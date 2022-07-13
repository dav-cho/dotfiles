local has_dap, dap = pcall(require, "dap")
if not has_dap then
  -- vim.notify("~ dap call error")
  return
end

-- TODO: different column signs?
-- tj:
-- vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "", linehl = "", numhl = "" })
-- -- Setup cool Among Us as avatar
-- vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })


---- nvim-dap-virtual-text
require("nvim-dap-virtual-text").setup {
  enabled = true,
  enabled_commands = false,
  highlight_changed_variables = true,
  highlight_new_as_changed = true,
  show_stop_reason = true,
  commented = false,
  all_references = false,

  -- experimental features:
  virt_text_pos = 'eol',
  all_frames = false,
}


---- dap-python
-- TODO
-- dap.configurations.python = {
--   {
--     type = "python",
--     request = "launch",
--     name = "Build api",
--     program = "${file}",
--     args = { "--target", "api" },
--     console = "integratedTerminal",
--   },
--   {
--     type = "python",
--     request = "launch",
--     name = "lsif",
--     program = "src/lsif/__main__.py",
--     args = {},
--     console = "integratedTerminal",
--   },
-- }

local dap_python = require "dap-python"

-- dap_python.setup("/Users/dcho/.local/share/virtualenvs/nvim-dap-WBKJo5_-/bin/python", {
--   console = "externalTerminal",
--   include_configs = true,
-- })
-- dap_python.setup("/Users/dcho/.local/share/virtualenvs/nvim-dap-WBKJo5_-/bin/python")
dap_python.setup("/Users/dcho/.local/share/virtualenvs/nvim-dap-WBKJo5_-/bin/python", {
  console = "externalTerminal",
  -- include_configs = true, -- TODO
})
-- dap_python.setup("python")

dap_python.test_runner = "pytest"

---- Keymaps
local map = function(lhs, rhs, desc)
  if desc then
    desc = "[DAP] " .. desc
  end

  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
  -- vim.api.nvim_set_keymap("n", lhs, rhs, { silent = true, desc = desc })
end

map("<F5>", require("dap").continue, "continue")
map("<F10>", require("dap").step_over, "step_over")
map("<F11>", require("dap").step_into, "step_into")
map("<F12>", require("dap").step_out, "step_out")
-- map("<S-F11>", require("dap").step_out, "step_out") -- VSCode style

map("<leader>db", require("dap").toggle_breakpoint)
map("<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "[DAP] Conditon > ")
end)

-- map("<leader>do", require("dap").open) -- TODO
map("<leader>dr", require("dap").repl.open)
-- map("<leader>de", require("dap").eval) -- TODO
map("<leader>dE", function()
  require("dapui").eval(vim.fn.input "[DAP] Expression > ")
end)

-- TODO
map("<leader>pm", require("dap-python").test_method)
map("<leader>pc", require("dap-python").test_class)
map("<leader>ps", require("dap-python").debug_selection)


-- TODO
-- tj:
-- -- You can set trigger characters OR it will default to '.'
-- -- You can also trigger with the omnifunc, <c-x><c-o>
-- vim.cmd [[
-- augroup DapRepl
--   au!
--   au FileType dap-repl lua require('dap.ext.autocompl').attach()
-- augroup END
-- ]]


---- nvim-dap-ui
local dapui = require "dapui"

dapui.setup()

-- Automatically close and open windows from dap events
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end



-- TODO
-- tj:
-- local _ = dap_ui.setup {
--   -- You can change the order of elements in the sidebar
--   sidebar = {
--     elements = {
--       -- Provide as ID strings or tables with "id" and "size" keys
--       {
--         id = "scopes",
--         size = 0.75, -- Can be float or integer > 1
--       },
--       { id = "watches", size = 00.25 },
--     },
--     size = 50,
--     position = "left", -- Can be "left" or "right"
--   },
--
--   tray = {
--     elements = {},
--     size = 15,
--     position = "bottom", -- Can be "bottom" or "top"
--   },
-- }

-- TODO
-- this will map and unmap keymaps you want to use while debugging only
-- tj:
-- local original = {}
-- local debug_map = function(lhs, rhs, desc)
--   local keymaps = vim.api.nvim_get_keymap "n"
--   original[lhs] = vim.tbl_filter(function(v)
--     return v.lhs == lhs
--   end, keymaps)[1] or true
--
--   vim.keymap.set("n", lhs, rhs, { desc = desc })
-- end
--
-- local debug_unmap = function()
--   for k, v in pairs(original) do
--     if v == true then
--       vim.keymap.del("n", k)
--     else
--       local rhs = v.rhs
--
--       v.lhs = nil
--       v.rhs = nil
--       v.buffer = nil
--       v.mode = nil
--       v.sid = nil
--       v.lnum = nil
--
--       vim.keymap.set("n", k, rhs, v)
--     end
--   end
--
--   original = {}
-- end
--


---- TODO

---- Python
-- dap.adapters.python = {
-- }
--
-- dap.configuations.python = {
-- }

---- Lua
-- dap.adapters.lua = {
-- }
--
-- dap.configuations.lua = {
-- }
--
---- Golang
-- dap.adapters.go = {
-- }
--
-- dap.configuations.go = {
-- }
