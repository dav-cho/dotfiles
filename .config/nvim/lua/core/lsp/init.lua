local ok, _ = pcall(require, "lspconfig")
if not ok then
  vim.notify('~ LSP Config Call Error!')
  return
end

require 'core.lsp.config'
require 'core.lsp.handlers'.setup()
require 'core.lsp.null-ls'

