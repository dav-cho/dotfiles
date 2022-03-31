local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify(string.format("~ %s Call Error!", module))
end

local ls = prequire('luasnip')
local from_vscode = prequire('luasnip.loaders.from_vscode')

ls.filetype_extend('javascriptreact', {'javascript'})
ls.filetype_extend('typescriptreact', {'typescript'})

-- from_vscode.load({ paths = { '~/Library/Application Support/Code/User/snippets' }})
from_vscode.lazy_load({ paths = { '~/Library/Application Support/Code/User/snippets' }})

