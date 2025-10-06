vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.keymap.set("n", "<Leader>po", "oconsole.log('-'.repeat(100));<Esc>", { desc = "print line below" })
vim.keymap.set("n", "<Leader>pO", "Oconsole.log('-'.repeat(100));<Esc>", { desc = "print line above" })
