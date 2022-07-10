local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  sources = {
    formatting.prettier.with {
      prefer_local = true,
      command = "/Users/dav/.config/prettier/node_modules/.bin/prettier",
      extra_filetypes = { "toml" },
      extra_args = { "--single-quote", "--arrow-parens=avoid", "--config-precedence=prefer-file" },
    },
    formatting.black,
    formatting.goimports.with {
      prefer_local = true,
      command = "/Users/dav/go/bin/goimports",
    },

    -- TODO
    -- diagnostics.zsh,
    --
    -- code_actions.gitsigns,
    -- code_actions.eslint,
  },
}
