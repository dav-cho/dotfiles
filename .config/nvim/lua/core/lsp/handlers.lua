local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify('~ ' .. module .. ' Call Error!')
end

local lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fm', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fm', '<cmd>Format<CR>', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]]
end

-- Word Highlighting
local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    local illuminate = prequire('illuminate')
    illuminate.on_attach(client)
  end
end

local M = {}

M.setup = function()
  -- local icons = require "user.icons"
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

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
    -- severity_sort = true,
  }

  vim.diagnostic.config(diagnostic_config)

  local hover_config = {
    -- style = 'minimal',
    border = 'single',
    source = 'always',
    -- source = 'if_many',
    -- header = '',
    -- prefix = '',
  }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, hover_config)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, hover_config)
end

M.on_attach = function(client, bufnr)
  local format_ignore_list = { 'tsserver', 'jsonls', 'gopls', 'html' }
  for _, v in ipairs(format_ignore_list) do
    if client.name == v then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmp_nvim_lsp = prequire('cmp_nvim_lsp')
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)




-- Set autocommands conditional on server capabilities
-- if client.resolved_capabilities.document_highlight then
--   vim.cmd [[
--   augroup lsp_document_highlight
--   autocmd! * <buffer>
--   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--   augroup END
--   ]]
-- end
--
-- require'lspconfig'.gopls.setup {
--   on_attach = function(client)
--     -- [[ other on_attach code ]]
--     require 'illuminate'.on_attach(client)
--   end,
-- }

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = {
--   --'clangd',
--   --'rust_analyzer',
--   'pyright',
--   'tsserver'
-- }
--
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     -- on_attach = my_custom_on_attach,
--     capabilities = capabilities,
--   }
-- end

return M
