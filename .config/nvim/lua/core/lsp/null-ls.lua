local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify(string.format('~ %s Call Error!', module))
end

local null_ls = prequire 'null-ls'
local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
-- local completion = null_ls.builtins.completion

-- local formatting = prequire 'null-ls'.builtins.formatting
-- local diagnostics = prequire 'null-ls'.builtins.diagnostics
-- local completion = prequire 'null-ls'.builtins.completion

null_ls.setup {
    sources = {
        -- formatting.eslint,
        formatting.prettier.with {
          extra_filetypes = { 'toml' },
          extra_args = { '--single-quote', '--arrow-parens=avoid' },
        },
        formatting.black,
        formatting.stylua,

        --diagnostics.eslint,

        --completion.spell,
    },
}

