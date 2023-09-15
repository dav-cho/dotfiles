vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "89"

vim.keymap.set("n", "<leader>py", "<Cmd>!python %<CR>", { buffer = true, desc = ":!python %" })
vim.keymap.set("n", "<leader>pe", "<Cmd>!pipenv run python %<CR>", { buffer = true, desc = ":!pipenv run python %" })
vim.keymap.set(
  "n",
  "<leader>pi",
  function()
    vim.cmd(string.format([[TermExec cmd="python %s"]], vim.fn.expand("%:~:.")))
  end,
  { buffer = true, desc = "[ToggleTerm] python %" }
)
vim.keymap.set("n", "<Space>#", "O# TODO: ", { buffer = true, desc = "Add TODO above with comment" })
vim.keymap.set("n", "<Space>$", "A  # TODO: ", { buffer = true, desc = "Append TODO EOL with comment" })
vim.keymap.set("n", "<leader>#", "O# TODO<Esc>", { buffer = true, desc = "Add TODO above" })
vim.keymap.set("n", "<leader>$", "A  # TODO<Esc>", { buffer = true, desc = "Append TODO EOL" })
vim.keymap.set("n", "<leader>--", "o<Esc>88i#<Esc>0o<Esc>k", { buffer = true, desc = "Insert line break comment" })
vim.keymap.set("n", "<leader>ym", function()
  local module = vim.fn.expand("%:~:.")
  module = string.gsub(module, "/", ".")
  module = string.gsub(module, ".py$", "")
  vim.fn.setreg("+", module)
  return module
end, { buffer = true, desc = "Yank module name" })
