vim.g.transparent_background = true

local colorscheme = "darkplus"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  return
end

vim.cmd "highlight SignColumn guibg=none"
vim.cmd "highlight CursorLine guibg=none"
vim.cmd "highlight CursorLineNr guifg=#FFB13B"
vim.cmd "highlight NormalFloat cterm=none gui=none guifg=none guibg=#1E1E1E"
vim.cmd "highlight WinSeparator cterm=none gui=none guifg=none guibg=#1E1E1E"
