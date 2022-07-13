local buf_nnoremap = require("dav.utils.keymap").buf_nnoremap

local keymaps = function(bufnr)
  local opts = { silent = true }

  buf_nnoremap(bufnr, "gD", vim.lsp.buf.declaration, opts)
  buf_nnoremap(bufnr, "gd", vim.lsp.buf.definition, opts)
  buf_nnoremap(bufnr, "gh", vim.lsp.buf.hover, opts)
  buf_nnoremap(bufnr, "gi", vim.lsp.buf.implementation, opts)
  buf_nnoremap(bufnr, "<C-k>", vim.lsp.buf.signature_help, opts)
  buf_nnoremap(bufnr, "gl", vim.diagnostic.open_float, opts)
  buf_nnoremap(bufnr, "<leader>D", vim.lsp.buf.type_definition, opts)
  buf_nnoremap(bufnr, "<leader>rn", vim.lsp.buf.rename, opts)
  buf_nnoremap(bufnr, "gr", vim.lsp.buf.references, opts)
  buf_nnoremap(bufnr, "<leader>ca", vim.lsp.buf.code_action, opts)

  vim.cmd [[ command! Format execute "lua vim.lsp.buf.formatting_sync()" ]]
end

local highlight_document = function(client)
  if client.resolved_capabilities.document_highlight then
    require("illuminate").on_attach(client)
  end
end

local M = {}

-- TODO
-- M.on_init = function(client)
--   client.config.flags = client.config.flags or {}
--   client.config.flags.allow_incremental_sync = true
-- end

M.on_attach = function(client, bufnr)
  -- TODO: See last line in function.
  -- local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  -- TODO: Use after null-ls setup.
  -- local format_ignore_list = { 'tsserver', 'jsonls', 'gopls', 'html' }
  -- for _, v in ipairs(format_ignore_list) do
  --   if client.name == v then
  --     client.resolved_capabilities.document_formatting = false
  --     client.resolved_capabilities.document_range_formatting = false
  --   end
  -- end

  -- TODO
  -- if nvim_status then
  --   nvim_status.on_attach(client)
  -- end

  keymaps(bufnr)
  highlight_document(client)

  -- TODO: See first line in function.
  -- filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = updated_capabilities

return M


-- TODO:
-- return {
--   on_init = custom_init,
--   on_attach = custom_attach,
--   capbilities = updated_capabilities,
-- }
