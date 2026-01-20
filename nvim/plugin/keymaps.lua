local map = vim.keymap.set

map("n", "<Esc>", function()
  return vim.v.hlsearch == 1 and "<Cmd>nohlsearch<CR><ESC>" or "<Esc>"
end, { expr = true, desc = "Escape | nohlsearch" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal Escape" })
map("n", "<BS>", "<Tab>", { desc = "Newer Jump List" })
map({ "n", "v" }, "<Leader><Tab>", "<C-^>", { desc = "Alternate file (`<C-^>`)" })
map({ "n", "v" }, "<Space><Tab>", "<C-^>", { desc = "Alternate file (`<C-^>`)" })

map("n", "<Space>w", "<Cmd>silent! w<CR>", { desc = "Write" })
map("n", "<Space>W", "<Cmd>silent! wa<CR>", { desc = "Write All" })
map({ "n", "v" }, "<C-q>", "<Cmd>qa<CR>", { desc = "Quit all" })
map({ "n", "v" }, "<M-Q>", "<Cmd>qa!<CR>", { desc = "Quit all (force)" })

map({ "n", "v" }, "<C-c>", "<Cmd>wincmd c<CR>", { desc = ":wincmd c" })
map({ "n", "v" }, "<C-h>", [[<Cmd>exe v:count1 . "wincmd h"<CR>]], { desc = ":wincmd h" })
map({ "n", "v" }, "<C-j>", [[<Cmd>exe v:count1 . "wincmd j"<CR>]], { desc = ":wincmd j" })
map({ "n", "v" }, "<C-k>", [[<Cmd>exe v:count1 . "wincmd k"<CR>]], { desc = ":wincmd k" })
map({ "n", "v" }, "<C-l>", [[<Cmd>exe v:count1 . "wincmd l"<CR>]], { desc = ":wincmd l" })

map({ "n", "v" }, "<Leader>w", "<C-w>", { desc = "Window command" })
map({ "n", "v" }, "<Leader>wX", "<C-w>x<C-w>p", { desc = "Swap window keep cursor" })

map({ "n", "v" }, "<Leader>wt", "<Cmd>tab split<CR>", { desc = ":tab split" })
map({ "n", "v" }, "<Leader>wT", "<Cmd>wincmd T<CR>", { desc = ":wincmd T" })
map({ "n", "v" }, "<S-Right>", function()
  vim.cmd.tabnext((vim.fn.tabpagenr() - 1 + vim.v.count1) % vim.fn.tabpagenr("$") + 1)
end, { desc = "[count] next tab" })
map({ "n", "v" }, "<S-Left>", function()
  vim.cmd.tabprevious(vim.v.count1)
end, { desc = "[count] previous tab" })
map({ "n", "v" }, "<PageUp>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map({ "n", "v" }, "<PageDown>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
map({ "n", "v" }, "<Leader><", "<Cmd>tabm -1<CR>", { desc = "Move tab left" })
map({ "n", "v" }, "<Leader>>", "<Cmd>tabm +1<CR>", { desc = "Move tab right" })
map("n", "<M-x>", "<Cmd>tabc<CR>", { desc = "Close tab" })

map("n", "<M-c>", "<Cmd>bd<CR>", { desc = "Unload buffer" })
map("n", "<M-C>", "<Cmd>bd!<CR>", { desc = "Unload buffer (force)" })

local function search_keep_pos(cmd)
  return function()
    local view = vim.fn.winsaveview()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! " .. cmd)
    vim.fn.winrestview(view)
    vim.api.nvim_win_set_cursor(0, cursor)
  end
end

map("n", "*", search_keep_pos("*"), { desc = "Search word forward" })
map("n", "#", search_keep_pos("#"), { desc = "Search word backward" })
map("n", "g*", search_keep_pos("g*"), { desc = "Search word forward (partial)" })
map("n", "g#", search_keep_pos("g#"), { desc = "Search word backward (partial)" })
map("v", "*", [["by/\V<C-r>b<CR>`<]], { desc = "Search selection forward" })
map("v", "#", [["by?\V<C-r>b<CR>`<]], { desc = "Search selection backward" })
map("n", "<C-n>", "nzz", { desc = "Repeat search, redraw line center" })
map("n", "<C-p>", "Nzz", { desc = "Repeat search reverse, redraw line center" })
map("n", "<M-C-n>", "nzt", { desc = "Repeat search, redraw top" })

map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("x", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("x", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
map({ "n", "i" }, "<S-down>", function()
  for _ = 1, vim.v.count1 do
    vim.cmd("call append(line('.'), getline('.'))")
  end
end, { desc = "Copy line down" })
map({ "n", "i" }, "<S-up>", function()
  for _ = 1, vim.v.count1 do
    vim.cmd("call append(line('.')-1, getline('.'))")
  end
end, { desc = "Copy line up" })

map("n", "<M-J>", "m`J``", { desc = "Join lines, keep cursor" })

map("v", "gy", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd("normal! y")
  vim.api.nvim_win_set_cursor(0, { row, col })
end, { desc = "Yank selection, keep cursor position" })
map("v", "<M-y>", "ygv", { desc = "Yank selection and reselect" })

map("n", "<Leader>yf", [[<Cmd>let @+=expand("%:t")<CR>]], { desc = "Yank file name" })
map("n", "<Leader>yr", [[<Cmd>let @+=expand("%:~:.")<CR>]], { desc = "Yank relative file path" })
map("n", "<Leader>ya", [[<Cmd>let @+=fnamemodify(expand("%:p"), ":~")<CR>]], { desc = "Yank abbreviated file path" })
map("n", "<Leader>yA", [[<Cmd>let @+=expand("%:p")<CR>]], { desc = "Yank absolute file path" })

map("n", "<Leader>tt", ":vert term<CR>", { desc = "Terminal" })

map("n", "<Space>q", "<Cmd>copen<CR>", { desc = "Open qflist" })
map("n", "<Space>[", "<Cmd>cprevious<CR>", { desc = "qflist previous" })
map("n", "<Space>]", "<Cmd>cnext<CR>", { desc = "qflist next" })

map("n", "<Space>l", "<Cmd>lopen<CR>", { desc = "Open loclist" })
map("n", "<Space>_", "<Cmd>lprevious<CR>", { desc = "loclist previous" })
map("n", "<Space>+", "<Cmd>lnext<CR>", { desc = "loclist next" })

map({ "n", "v" }, "z<Bslash>", function()
  local rows = math.floor(vim.api.nvim_win_get_height(0) * 0.25)
  rows = rows - vim.opt.scrolloff:get()
  vim.api.nvim_input(string.format("zt%d<C-y>", rows))
end, { desc = "Redraw cursor line top 25%" })
map({ "n", "v" }, "z<Space>", function()
  local rows = math.floor(vim.api.nvim_win_get_height(0) * 0.25)
  rows = rows - vim.opt.scrolloff:get()
  vim.api.nvim_input(string.format("zt%d<C-y>", rows))
end, { desc = "Redraw cursor line top 25%" })
map({ "n", "v" }, "<Space><BS>", function()
  local rows = math.floor(vim.api.nvim_win_get_height(0) * 0.1)
  rows = rows - vim.opt.scrolloff:get()
  vim.api.nvim_input(string.format("zb%d<C-e>", rows))
end, { desc = "Redraw cursor line bottom 10%" })

map("n", "<Leader>ms", function()
  vim.cmd("mksession!")
  print(string.format("Session Saved: %s/Session.vim", vim.fn.getcwd()))
end, { silent = true, desc = "[Sessions] mksession" })

map("n", "<Leader>ve", function()
  vim.api.nvim_set_option_value(
    "virtualedit",
    #vim.api.nvim_get_option_value("virtualedit", { scope = "local" }) > 0 and "" or "block",
    { scope = "local" }
  )
end, { desc = "toggle virtualedit=block" })
map("n", "<Leader>lz", "<Cmd>Lazy<CR>", { desc = "Lazy" })
