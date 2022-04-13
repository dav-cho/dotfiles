-- local prequire = function(module)
--   local ok, lib = pcall(require, module)
--   if ok then return lib end
--   vim.notify(string.format('~ %s Call Error!', module))
-- end

-- local lspconfig = prequire('lspconfig')
-- local util = prequire('lspconfig.util')


return {
  -- cmd = {'gopls', 'serve'},
  -- filetypes = {'go', 'gomod'},
  -- root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  -- settings = {
  --   gopls = {
  --     --   analyses = {
  --     --     unusedparams = true,
  --     --   },
  --     --   statickcheck = true,
  --     ui = {
  --       completion = false,
  --     }
  --   },
  -- },
  cmd = {'gopls'},
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  }
}
