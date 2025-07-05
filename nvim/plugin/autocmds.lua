vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("GlobalOptions", {}),
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

vim.api.nvim_create_augroup("RelativeNumberToggle", {})
vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter", "WinEnter", "FocusGained" }, {
  group = "RelativeNumberToggle",
  callback = function()
    if vim.api.nvim_get_option_value("number", {}) then
      vim.opt.relativenumber = true
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "BufLeave", "WinLeave", "FocusLost" }, {
  group = "RelativeNumberToggle",
  callback = function()
    if vim.api.nvim_get_option_value("relativenumber", {}) then
      vim.opt.relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CloseWithQ", {}),
  pattern = {
    "fugitive",
    "fugitiveblame",
    "fzf",
    "git",
    "gitsigns-blame",
    "help",
    "man",
    "notify",
    "qf",
    "toggleterm",
  },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TermBufOpts", {}),
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
    vim.keymap.set("t", "<Esc>", "<C-Bslash><C-n>", { buffer = 0 }) -- also for toggleterm
    vim.cmd("normal! i")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("DockerComposeYaml", {}),
  pattern = { "yaml" },
  callback = function(ev)
    local filename = vim.fn.expand("#" .. ev.buf .. ":t")
    if filename:match("^docker%-compose") then
      vim.bo[ev.buf].filetype = "yaml.docker-compose"
    end
  end,
})
