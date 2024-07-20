local map = vim.keymap.set

-- WIP
local function goto_window()
end

local function goto_tab(cmd)
  if vim.v.count > 0 then
    return vim.cmd(cmd .. vim.v.count)
  end
  return vim.cmd(cmd)
end

local function search_keep_pos(dir)
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! " .. dir)
  vim.api.nvim_win_set_cursor(0, cursor)
end

map("n", "<Space>w", "<Cmd>silent! w<CR>", { desc = "Write" })
map("n", "<Space>W", "<Cmd>wa<CR>", { desc = "Write All" })
map({ "n", "v" }, "<C-q>", "<Cmd>qa<CR>", { desc = "Quit all" })
map({ "n", "v" }, "<M-q>", "<Cmd>qa!<CR>", { desc = "Quit all (force)" })

map("n", "<M-c>", "<Cmd>bd<CR>", { desc = "Unload buffer" })
map("n", "<Leader><C-c>", "<Cmd>bd<CR>", { desc = "Unload buffer" })
map("n", "<M-C>", "<Cmd>bd!<CR>", { desc = "Unload buffer (force)" })
map("n", "<Leader><Tab>", "<C-^>", { desc = "Alternate file" })
map("n", "<BS>", "<Tab>", { desc = "Newer Jump List" })

map({ "n", "v" }, "<Leader>w", "<C-w>", { desc = "Window command" })
map({ "n", "v" }, "<C-c>", "<Cmd>wincmd c<CR>", { desc = "Close window" })
map({ "n", "v" }, "<C-h>", [[<Cmd>exe v:count1 . "wincmd h"<CR>]], { desc = "Window left" })
map({ "n", "v" }, "<C-j>", [[<Cmd>exe v:count1 . "wincmd j"<CR>]], { desc = "Window down" })
map({ "n", "v" }, "<C-k>", [[<Cmd>exe v:count1 . "wincmd k"<CR>]], { desc = "Window up" })
map({ "n", "v" }, "<C-l>", [[<Cmd>exe v:count1 . "wincmd l"<CR>]], { desc = "Window right" })

map("n", "<M-x>", "<Cmd>tabc<CR>", { desc = "Close tab" })
map("n", "<Leader><C-x>", "<Cmd>tabc<CR>", { desc = "Close tab" })
map({ "n", "v" }, "<Leader>wt", "<Cmd>tabedit %<CR>", { desc = "Current window new tab" })
map({ "n", "v" }, "<Leader><", "<Cmd>tabm -1<CR>", { desc = "Move tab left" })
map({ "n", "v" }, "<Leader>>", "<Cmd>tabm +1<CR>", { desc = "Move tab right" })
map({ "n", "v" }, "<PageUp>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map({ "n", "v" }, "<PageDown>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
map({ "n", "v" }, "<S-Right>", function()
  goto_tab("tabnext")
end, { desc = "[count]tabnext" })
map({ "n", "v" }, "<S-Left>", function()
  goto_tab("tabprevious")
end, { desc = "[count]tabprevious" })

map("n", "<Esc>", function()
  return vim.v.hlsearch == 1 and "<Cmd>nohlsearch<CR><ESC>" or "<Esc>"
end, { expr = true, desc = "Escape | nohlsearch" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal Escape" })

map("n", "*", function()
  search_keep_pos("*")
end, { desc = "Search word forward" })
map("n", "#", function()
  search_keep_pos("#")
end, { desc = "Search word backward" })
map("v", "*", [[y/\V<C-r>"<CR>`<]], { desc = "Search selection forward" })
map("v", "#", [[y?\V<C-r>"<CR>`<]], { desc = "Search selection backward" })
map("n", "<C-n>", "nzz", { desc = "Repeat search, redraw line center" })
map("n", "<C-p>", "Nzz", { desc = "Repeat search reverse, redraw line center" })
map("n", "<M-C-n>", "nzt", { desc = "Repeat search, redraw top" })

map("v", "<M-y>", "ygv", { desc = "Yank selection and reselect" })
map({ "n", "x" }, "<M-P>", [["0p]], { desc = "Paste yank register" })
map("n", "<M-J>", "m`J``", { desc = "Join lines, return to last position" })

map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("x", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("x", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
map({ "n", "i" }, "<S-down>", "<cmd>call append(line('.'), getline('.'))<cr>", { desc = "Copy line down" })
map({ "n", "i" }, "<S-up>", "<cmd>call append(line('.')-1, getline('.'))<cr>", { desc = "Copy line up" })

map("n", "<Leader>yf", [[<Cmd>let @+=expand("%:t")<CR>]], { desc = "Yank file name" })
map("n", "<Leader>yr", [[<Cmd>let @+=expand("%:~:.")<CR>]], { desc = "Yank relative file path" })
map("n", "<Leader>ya", [[<Cmd>let @+=fnamemodify(expand("%:p"), ":~")<CR>]], { desc = "Yank abbreviated file path" })
map("n", "<Leader>yA", [[<Cmd>let @+=expand("%:p")<CR>]], { desc = "Yank absolute file path" })

map("n", "z<CR>", "zt", { desc = "zt" })
map("n", "<Space><CR>", function()
  local rows = math.floor(vim.api.nvim_win_get_height(0) / 5)
  rows = rows - vim.opt.scrolloff:get()
  vim.api.nvim_input(string.format("zt%d<C-y>", rows))
end, { desc = "Redraw cursor line top 1/5" })

map("n", "<Leader>tt", ":vert term<CR>", { desc = "Terminal" })

map("n", "<Space>q", "<Cmd>copen<CR>", { desc = "Open qflist" })
map("n", "<Space>-", "<Cmd>cprevious<CR>", { desc = "qflist previous" })
map("n", "<Space>=", "<Cmd>cnext<CR>", { desc = "qflist next" })

map("n", "<Space>l", "<Cmd>lopen<CR>", { desc = "Open loclist" })
map("n", "<Space>_", "<Cmd>lprevious<CR>", { desc = "loclist previous" })
map("n", "<Space>+", "<Cmd>lnext<CR>", { desc = "loclist next" })

map("n", "<Leader>ms", function()
  vim.cmd("mksession!")
  vim.notify(string.format("Session Saved: %s/Session.vim", vim.fn.getcwd()))
end, { silent = true, desc = "[Sessions] mksession" })

map("n", "<Leader>mn", function()
  vim.cmd("Man " .. vim.fn.input(":Man "))
end, { desc = ":Man <input>" })
map("n", "<Leader>vm", function()
  vim.cmd("vertical Man " .. vim.fn.input(":vertical Man "))
end, { desc = ":vertical Man <input>" })
map("n", "<Leader>mg", "<Cmd>messages<CR>", { desc = ":messages" })
map("n", "<Leader>lz", "<Cmd>Lazy<CR>", { desc = "Lazy" })
