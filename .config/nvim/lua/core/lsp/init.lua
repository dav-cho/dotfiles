local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify('~ LSP Config CALL ERROR')
  return
end

require 'core.lsp.lsp-installer'
require 'core.lsp.handlers'.setup()

