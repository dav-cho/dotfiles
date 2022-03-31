local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  vim.notify('~ null-ls Call Error!')
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
-- local completion = null_ls.builtins.completion

-- local formatting = prequire 'null-ls'.builtins.formatting
-- local diagnostics = prequire 'null-ls'.builtins.diagnostics
-- local completion = prequire 'null-ls'.builtins.completion

null_ls.setup {
    sources = {
        -- formatting.eslint,
        formatting.prettier.with {
          extra_filetypes = { 'toml' },
          -- extra_args = { '--single-quote', '--arrow-parens=avoid' },
        },
        formatting.black,
        formatting.gofmt,
        formatting.goimports,
        formatting.stylua,
        -- formatting.lua_format,

        -- diagnostics.eslint,
        diagnostics.zsh,

        --completion.spell,

        code_actions.gitsigns,
        code_actions.eslint,
    },
}

