-- TODO: Need to put these in custom_attach? Does it need to attach to every server?

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

local diagnostic_config = {
  underline = false,
  virtual_text = false,
  -- signs = "severity",
  -- signs = {
  --   active = signs,
  -- },
  float = {
    focusable = true,
    severity_sort = true,
    source = "always",
    header = "",
    prefix = "",
    style = "minimal",
    border = "single"
  },
  update_in_insert = true,
  -- severity_sort = true,
}

local hover_config = {
  focusable = true,
  border = "single",
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config(diagnostic_config)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, hover_config)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, hover_config)



-- TODO
-- -- Jump directly to the first available definition every time.
-- vim.lsp.handlers["textDocument/definition"] = function(_, result)
--   if not result or vim.tbl_isempty(result) then
--     print "[LSP] Could not find definition"
--     return
--   end
-- 
--   if vim.tbl_islist(result) then
--     vim.lsp.util.jump_to_location(result[1], "utf-8")
--   else
--     vim.lsp.util.jump_to_location(result, "utf-8")
--   end
-- end

