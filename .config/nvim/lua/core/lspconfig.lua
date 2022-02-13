----------------------------- LSP Config -----------------------------

local nvim_lsp = require('lspconfig')

---- Use an on_attach function to only map the following keys
---- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local buf_set_keymap_vim_lsp = function(before, after, opts)
    local options = { noremap = true, silent = true }
    local rhs = string.format('<cmd>lua vim.lsp.buf.%s<CR>', after)

    if opts then options = opts end

    vim.api.nvim_buf_set_keymap(bufnr, 'n', before, rhs, options)
  end

  local buf_set_keymap_diagnostic = function(before, after, opts)
    local options = { noremap = true, silent = true }
    local rhs = string.format('<cmd>lua vim.lsp.diagnostic.%s<CR>', after)

    if opts then options = opts end

    vim.api.nvim_buf_set_keymap(bufnr, 'n', before, rhs, options)
  end

  ----Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  ---- Mappings
  local opts = { noremap=true, silent=true }

  ---- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap_vim_lsp('gD', 'declaration()')
  buf_set_keymap_vim_lsp('gd', 'definition()')
  buf_set_keymap_vim_lsp('gh', 'hover()')
  buf_set_keymap_vim_lsp('K', 'hover()')
  buf_set_keymap_vim_lsp('gi', 'implementation()')
  --buf_set_keymap_vim_lsp('<C-k>', 'signature_help()')
  buf_set_keymap_vim_lsp('<space>wa', 'add_workspace_folder()')
  buf_set_keymap_vim_lsp('<space>wr', 'remove_workspace_folder()')
  buf_set_keymap_vim_lsp('<space>D', 'type_definition()')
  buf_set_keymap_vim_lsp('<space>rn', 'rename()')
  buf_set_keymap_vim_lsp('<space>ca', 'code_action()')
  buf_set_keymap_vim_lsp('gr', 'references()')
  buf_set_keymap_vim_lsp('<space>f', 'formatting()')

  buf_set_keymap_diagnostic('<space>e', 'show_line_diagnostics()')
  buf_set_keymap_diagnostic('[d', 'goto_prev()')
  buf_set_keymap_diagnostic(']d', 'goto_next()')
  buf_set_keymap_diagnostic('<space>q', 'set_loclist()')

  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

end

---- LSP Snippet Support
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true
--capabilities.textDocument.completion.completionItem.resolveSupport = {
--  properties = {
--    'documentation',
--    'detail',
--    'additionalTextEdits',
--  }
--}

---- Use a loop to conveniently call 'setup' on multiple servers and
---- map buffer local keybindings when the language server attaches
--local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
--for _, lsp in ipairs(servers) do
--  nvim_lsp[lsp].setup {
--    on_attach = on_attach,
--    flags = {
--      debounce_text_changes = 150,
--    },
--    capabilities = capabilities,
--  }
--end

---- Use a loop to conveniently call 'setup' on multiple servers and
---- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

---- Config for each server without loop function
--require'lspconfig'.pyright.setup {
--  on_attach = on_attach,
--  flags = {
--    debounce_text_changes = 150,
--  },
--  capabilities = capabilities,
--}
--require'lspconfig'.tsserver.setup {
--  on_attach = on_attach,
--  flags = {
--    debounce_text_changes = 150,
--  },
--  capabilities = capabilities,
--}

---- Make runtime paths discoverable to the server
--local runtime_path = vim.split(package.path, ';')
--table.insert(runtime_path, 'lua/?.lua')
--table.insert(runtime_path, 'lua/?/init.lua')

---- TODO: fix this
---- Peak Definition
local function preview_location_callback(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

-------------------------------- LSPs --------------------------------

---- Pyright
--require'lspconfig'.pyright.setup {}

---- tsserver
--require'lspconfig'.tsserver.setup {}

---- HTML
--npm i -g vscode-langservers-extracted

---- Enable (broadcasting) snippet capability for completion
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true
--
--require'lspconfig'.html.setup {
--  capabilities = capabilities,
--}

--require'lspconfig'.html.setup{}

---- Java
--require'lspconfig'.java_language_server.setup{}

---- jsonls
--npm i -g vscode-langservers-extracted

--require'lspconfig'.jsonls.setup {
--    commands = {
--      Format = {
--        function()
--          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
--        end
--      }
--    }
--}

--require'lspconfig'.jsonls.setup{}

---- GraphQL
--require'lspconfig'.graphql.setup{}

-------------------------------- Temp --------------------------------

  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

----------------------------------------------------------------------

