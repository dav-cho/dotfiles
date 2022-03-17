local ok, _ = pcall(require, "lspconfig")
if not ok then
  vim.notify('~ LSP Config CALL ERROR')
  return
end

require 'core.lsp.lsp-installer'
require 'core.lsp.handlers'.setup()

