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
  --   -- init_options = ts_utl.init_options,
  --   -- cmd = { "typescript-language-server", "--stio" },
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
  eslint = true,
  html = true,
  cssls = true,
  cssmodules_ls = true,
  emmet_ls = true,
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    -- on_init = require("dav.lsp.configs").on_init, -- TODO
    on_attach = require("dav.lsp.configs").on_attach,
    capbilities = require("dav.lsp.configs").capabilities,
    -- flags = {
    --   debounce_text_changes = nil,
    -- },
  }, config)

  lspconfig[server].setup(config)
end

require("nvim-lsp-installer").setup {
  automatic_installation = false, -- TODO: need?
  -- ensure_installed = { "sumneko_lua" , "gopls" }, -- TODO: setup gpls here?
  ensure_installed = { "sumneko_lua" },
}

setup_server("sumneko_lua", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

for server, config in pairs(servers) do
  setup_server(server, config)
end

require "dav.lsp.handlers"
require "dav.lsp.null-ls"

-- local telescope_mapper = require "dav.telescope.mappings" -- TODO



-- TODO: Ensure all servers from local 'servers' are installed?
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
