vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- TODO
-- vim.opt.shortmess:append "c"

local function prequire(module_name)
  local ok, module = pcall(require, module_name)
  if ok then
    return module
  end
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end


-- TODO

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
