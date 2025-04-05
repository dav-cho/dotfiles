local map = vim.keymap.set

local function search_keep_pos(cmd)
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! " .. cmd)
  vim.api.nvim_win_set_cursor(0, cursor)
end

-- map("n", "<space><leader>", function()
--   vim.notify(vim.inspect(vim.fn.getcwd()))
--   vim.notify(vim.inspect(vim.fn.expand("~/cm")))
--   vim.notify(vim.inspect(vim.startswith(vim.fn.getcwd(), vim.fn.expand("~/cm"))))
-- end)

map("n", "<Space>w", "<Cmd>silent! w<CR>", { desc = "Write" })
map("n", "<Space>W", "<Cmd>silent! wa<CR>", { desc = "Write All" })
map({ "n", "v" }, "<C-q>", "<Cmd>qa<CR>", { desc = "Quit all" })
map({ "n", "v" }, "<M-q>", "<Cmd>qa!<CR>", { desc = "Quit all (force)" })

map("n", "<BS>", "<Tab>", { desc = "Newer Jump List" })
map("n", "<M-->", "-", { desc = "- <minus>" })
map("n", "<M-_>", "_", { desc = "_ <underscore>" })
map("n", "<M-c>", "<Cmd>bd<CR>", { desc = "Unload buffer" })
map("n", "<Leader><C-c>", "<Cmd>bd<CR>", { desc = "Unload buffer" })
map("n", "<M-C>", "<Cmd>bd!<CR>", { desc = "Unload buffer (force)" })
map({ "n", "v" }, "<Leader><Tab>", "<C-^>", { desc = "Alternate file" })

map({ "n", "v" }, "<C-c>", "<Cmd>wincmd c<CR>", { desc = "Close window" })
map({ "n", "v" }, "<C-h>", [[<Cmd>exe v:count1 . "wincmd h"<CR>]], { desc = "Window left" })
map({ "n", "v" }, "<C-j>", [[<Cmd>exe v:count1 . "wincmd j"<CR>]], { desc = "Window down" })
map({ "n", "v" }, "<C-k>", [[<Cmd>exe v:count1 . "wincmd k"<CR>]], { desc = "Window up" })
map({ "n", "v" }, "<C-l>", [[<Cmd>exe v:count1 . "wincmd l"<CR>]], { desc = "Window right" })

map({ "n", "v" }, "<Leader>w", "<C-w>", { desc = "Window command" })
map({ "n", "v" }, "<Leader>wt", "<Cmd>tab split<CR>", { desc = ":tab split" })
map({ "n", "v" }, "<Leader>wT", "<Cmd>wincmd T<CR>", { desc = ":wincmd T" })
map({ "n", "v" }, "<Leader>wX", "<C-w>x<C-w>p", { desc = "Swap window keep cursor" })

-- map({ "n", "v" }, "<Leader>wX", function()
--   local win = vim.api.nvim_get_current_win()
--   vim.cmd("wincmd h")
--   if vim.api.nvim_get_current_win() ~= win then
--     vim.cmd("wincmd x")
--   end
-- end, { desc = "Swap window prev" })
-- map({ "n", "v" }, "<Leader>wX", "<C-w>W<C-w>x", { desc = "Swap window prev" })
-- map({ "n", "v" }, "<Leader>wX", "<C-w>p<C-w>x", { desc = "Swap window prev" })

-- map({ "n", "v" }, "<Leader>wx", function()
--   local wins = vim.api.nvim_list_wins()
--   for i, w in ipairs(wins) do
--     if w == vim.api.nvim_get_current_win() then
--       local next_idx = (i + vim.v.count) % #wins + 1
--       vim.cmd(string.format("%d wincmd x | wincmd w", next_idx))
--       break
--     end
--   end
-- end, { desc = "swap next window" })
-- map({ "n", "v" }, "<Leader>wX", function()
--   local wins = vim.api.nvim_list_wins()
--   for i, w in ipairs(wins) do
--     if w == vim.api.nvim_get_current_win() then
--       local prev_idx = i > 1 and (i - vim.v.count - 1) % #wins or #wins
--       vim.cmd(string.format("%d wincmd x | wincmd W", prev_idx))
--       break
--     end
--   end
-- end, { desc = "swap previous window" })
-- map({ "n", "v" }, "<C-w>X", function()
--   local wins = vim.api.nvim_list_wins()
--   for i, w in ipairs(wins) do
--     if w == vim.api.nvim_get_current_win() then
--       local prev_idx = i > 1 and (i - vim.v.count - 1) % #wins or #wins
--       vim.cmd(string.format("%d wincmd x", prev_idx))
--       break
--     end
--   end
-- end, { desc = "swap previous window (keep cursor in same window)" })

map("n", "<M-x>", "<Cmd>tabc<CR>", { desc = "Close tab" })
map("n", "<Leader><C-x>", "<Cmd>tabc<CR>", { desc = "Close tab" })
map({ "n", "v" }, "<Leader><", "<Cmd>tabm -1<CR>", { desc = "Move tab left" })
map({ "n", "v" }, "<Leader>>", "<Cmd>tabm +1<CR>", { desc = "Move tab right" })
map({ "n", "v" }, "<PageUp>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map({ "n", "v" }, "<PageDown>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
map({ "n", "v" }, "<S-Right>", function()
  if vim.v.count > 0 then
    return vim.cmd("tabnext" .. vim.v.count)
  end
  return vim.cmd("tabnext")
end, { desc = "[count]tabnext" })
map({ "n", "v" }, "<S-Left>", function()
  if vim.v.count > 0 then
    return vim.cmd("tabprevious" .. vim.v.count)
  end
  return vim.cmd("tabprevious")
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
map("n", "g*", function()
  search_keep_pos("g*")
end, { desc = "Search word forward (partial)" })
map("n", "g#", function()
  search_keep_pos("g#")
end, { desc = "Search word backward (partial)" })
map("v", "*", [["by/\V<C-r>b<CR>`<]], { desc = "Search selection forward" })
map("v", "#", [["by?\V<C-r>b<CR>`<]], { desc = "Search selection backward" })
map("n", "<C-n>", "nzz", { desc = "Repeat search, redraw line center" })
map("n", "<C-p>", "Nzz", { desc = "Repeat search reverse, redraw line center" })
map("n", "<M-C-n>", "nzt", { desc = "Repeat search, redraw top" })

map("v", "gy", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd("normal! y")
  vim.api.nvim_win_set_cursor(0, { row, col })
end, { desc = "Yank selection and maintain cursor position" })
map("v", "<M-y>", "ygv", { desc = "Yank selection and reselect" })
map({ "n", "x" }, "<M-P>", [["0p]], { desc = "Paste yank register" })
map("n", "<M-J>", "m`J``", { desc = "Join lines, return to last position" })

map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("x", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("x", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
map({ "n", "i" }, "<S-down>", "<Cmd>call append(line('.'), getline('.'))<CR>", { desc = "Copy line down" })
map({ "n", "i" }, "<S-up>", "<Cmd>call append(line('.')-1, getline('.'))<CR>", { desc = "Copy line up" })

map("n", "<Leader>yf", [[<Cmd>let @+=expand("%:t")<CR>]], { desc = "Yank file name" })
map("n", "<Leader>yr", [[<Cmd>let @+=expand("%:~:.")<CR>]], { desc = "Yank relative file path" })
map("n", "<Leader>ya", [[<Cmd>let @+=fnamemodify(expand("%:p"), ":~")<CR>]], { desc = "Yank abbreviated file path" })
map("n", "<Leader>yA", [[<Cmd>let @+=expand("%:p")<CR>]], { desc = "Yank absolute file path" })

map({ "n", "v" }, "z<CR>", "zt", { noremap = true, desc = "zt" })
map({ "n", "v" }, "<Space><CR>", function()
  local rows = math.floor(vim.api.nvim_win_get_height(0) / 5)
  rows = rows - vim.opt.scrolloff:get()
  vim.api.nvim_input(string.format("zt%d<C-y>", rows))
end, { desc = "Redraw cursor line top 1/5" })
map({ "n", "v" }, "<Space><BS>", function()
  local rows = math.floor(vim.api.nvim_win_get_height(0) / 5)
  rows = rows - vim.opt.scrolloff:get()
  vim.api.nvim_input(string.format("zb%d<C-e>", rows))
end, { desc = "Redraw cursor line bottom 1/5" })

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
