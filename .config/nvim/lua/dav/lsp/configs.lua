local buf_nnoremap = require("dav.utils.keymap").buf_nnoremap

local ok, lsp_installer = pcall(require, "nvimj-lsp-installer")
if not ok then
  return
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local servers = {
  pyright = true,

  gopls = true,
  -- TODO
  -- gopls = {
  --   cmd = { "gopls" },
  -- },

  tsserver = true,
  -- TODO
  -- tsserver = {
  --   -- init_options = ts_utl.init_options, -- TODO
  --   -- cmd = { "typescript-language-server", "--stio" }, -- TODO
  --   filetypes = {
  --     "javascript",
  --     "javascriptreact",
  --     "javascript.jsx",
  --     "typescript",
  --     "typescriptreact",
  --     "typescript.tsx",
  --   },
  -- },

  rust_analyzer = true,
  kotlin_language_server = true,
  bashls = true,
  dockerls = true,
  sqls = true,
  jsonls = true,
  yamlls = true,
  sumneko_lua = true,
  eslint = true,
  html = true,
  cssls = true,
  cssmodules_ls = true,
  emmet_ls = true,
}

local keymaps = function(bufnr)
  local opts = { silent = true }

  buf_nnoremap(bufnr, "gD", vim.lsp.buf.declaration)
  buf_nnoremap(bufnr, "gd", vim.lsp.buf.definition)
  buf_nnoremap(bufnr, "gh", vim.lsp.buf.hover)
  buf_nnoremap(bufnr, "gi", vim.lsp.buf.implementation)
  buf_nnoremap(bufnr, "<C-k>", vim.lsp.buf.signature_help)
  buf_nnoremap(bufnr, "gl", vim.diagnostic.open_float)
  buf_nnoremap(bufnr, "<leader>D", vim.lsp.buf.type_definition)
  buf_nnoremap(bufnr, "<leader>rn", vim.lsp.buf.rename)
  buf_nnoremap(bufnr, "gr", vim.lsp.buf.references)
  buf_nnoremap(bufnr, "<leader>ca", vim.lsp.buf.code_action)

  vim.cmd [[ command! Format execute "lua vim.lsp.buf.formatting_sync()" ]]
end

-- Word Highlighting
local highlight_document = function(client)
  if client.resolved_capabilities.document_highlight then
    require("illuminate").on_attach(client)
  end
end

local custom_attach = function(client, bufnr)
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

local updated_capabilities = vim.lsp.make_client_capabilities()
-- updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities) -- TODO: uncomment after setup cmp

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capbilities = updated_capbilities,
    -- flags = {
    --   debounce_text_changes = nil,
    -- },
  }, config)

  lspconfig[server].setup(config)
end

-- TODO
lsp_installer.setup {
  automatic_installation = false, -- TODO: need?
  -- ensure_installed = {},
}
--
-- require("nvim-lsp-installer").setup {
--   automatic_installation = false, -- TODO: need?
--   -- ensure_installed = {},
-- }
--
-- local list_servers = function(servers)
--   local list = {}
--   local i = 1
-- 
--   for server, _ in pairs(servers) do
--     list[i] = server
--     i += 1
--   end
-- 
--   return list
-- end
-- 
-- require("nvim-lsp-installer").setup {
--   automatic_installation = false,
--   -- ensure_installed = {},
--   ensure_installed = list_servers(servers),
-- }

for server, config in pairs(servers) do
  setup_server(server, config)
end

-- TODO: Don't need to return anything yet because these are not used for any other plugin configs.
-- return {
--   on_init = custom_init,
--   on_attach = custom_attach,
--   capbilities = updated_capabilities,
-- }
