vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.keymap.set("n", "<Leader>zf", function()
  vim.opt_local.foldnestmax = 1
  vim.opt_local.foldmethod = "expr"
  vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
end, { desc = "Set YAML treesitter folds" })