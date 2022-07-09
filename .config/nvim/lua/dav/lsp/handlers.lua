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
  signs = {
    active = signs,
  },
  float = {
    source = 'always',
    header = '',
    prefix = '',
  },
  update_in_insert = true,
}

local hover_config = {
  border = "single",
  source = "always",
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config(diagnostic_config)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, hover_config)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, hover_config)
