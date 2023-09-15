local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<Space>w", "<Cmd>w<CR>", { desc = "Write" })
map("n", "<Space>W", "<Cmd>wa<CR>", { desc = "Write All" })
map({ "n", "v" }, "<C-q>", "<Cmd>qa<CR>", { desc = "Quit all" })
map({ "n", "v" }, "<M-q>", "<Cmd>qa!<CR>", { desc = "Quit all (force)" })

map("n", "<C-c>", "<C-w>c", { desc = "Close window" })
map("n", "<M-c>", "<Cmd>bd<CR>", { desc = "Unload buffer" })
map("n", "<M-C>", "<Cmd>bd!<CR>", { desc = "Unload buffer (force)" })
map("n", "<M-x>", "<Cmd>tabc<CR>", { desc = "Close tab" })

map("n", "<leader>w", "<C-w>", { desc = "Window command" })
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<leader><Tab>", "<C-^>", { desc = "Alternate file" })
map("n", "<PageUp>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<PageDown>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>wt", "<Cmd>tabedit %<CR>", { desc = "Current window new tab" })
map("n", "g<", "<Cmd>tabm -1<CR>", { desc = "Move tab left" })
map("n", "g>", "<Cmd>tabm +1<CR>", { desc = "Move tab right" })

map("n", "<Esc>", function()
  return vim.v.hlsearch == 1 and "<Cmd>nohlsearch<CR><ESC>" or "<Esc>"
end, { expr = true, desc = "Escape and nohlsearch" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal Escape" })

map("n", "*", "*``", { desc = "Search word forward" })
map("n", "#", "#``", { desc = "Search word backward" })
map("v", "*", [[y/\V<C-r>"<CR>`<]], { desc = "Search selection forward" })
map("v", "#", [[y?\V<C-r>"<CR>`<]], { desc = "Search selection backward" })
map("n", "<M-C-n>", "nzt", { desc = "Repeat search, redraw top" })

map("x", "<M-y>", "ygv", { desc = "Yank selection and reselect" })
map({ "n", "x" }, "<M-P>", [["0p]], { desc = "Paste yank register" })
map("n", "<M-J>", "m`J``", { desc = "Join lines, return to last position" })

map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("x", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("x", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
map({ "n", "i" }, "<S-down>", "<cmd>call append(line('.'), getline('.'))<cr>", { desc = "Copy line down" })
map({ "n", "i" }, "<S-up>", "<cmd>call append(line('.')-1, getline('.'))<cr>", { desc = "Copy line up" })

map("n", "<leader>yf", [[<Cmd>let @+=expand("%:t")<CR>]], { desc = "Yank file name" })
map("n", "<leader>yr", [[<Cmd>let @+=expand("%:~:.")<CR>]], { desc = "Yank relative file path" })
map("n", "<leader>ya", [[<Cmd>let @+=fnamemodify(expand("%:p"), ":~")<CR>]], { desc = "Yank abbreviated file path" })
map("n", "<leader>yA", [[<Cmd>let @+=expand("%:p")<CR>]], { desc = "Yank absolute file path" })

map("n", "<Space><CR>", "zt", { desc = "Redraw cursor line top" })
map("n", "zz", function()
  local rows = math.floor(vim.api.nvim_win_get_height(0) / 4) - vim.opt.scrolloff:get()
  vim.api.nvim_input(string.format("zt%d<C-y>", rows))
end, { desc = "Redraw cursor line top third" })

map("n", "<leader>vm", ":vertical Man ", { desc = ":Man" })

map("n", "<Space>q", "<Cmd>copen<CR>", { desc = "Open qflist" })
map("n", "<leader>cq", function() vim.fn.setqflist({}, "f") end, { desc = "Reset qflist" })
map("n", "<Space>]", "<Cmd>cnext<CR>", { desc = "qflist next" })
map("n", "<Space>[", "<Cmd>cprevious<CR>", { desc = "qflist previous" })
map(
  "n",
  "<M-a>",
  function()
    local pos = vim.fn.getcurpos()
    vim.fn.setqflist({
      {
        bufnr = vim.fn.bufnr(),
        lnum = pos[2],
        col = pos[3],
        text = vim.fn.getline(pos[2]),
        type = "",
      }
    }, "a")
  end,
  { desc = "setqflist" }
)

map("n", "<Space>a", "<Cmd>lopen<CR>", { desc = "Open loclist" })
map("n", "<leader>cl", function() vim.fn.setloclist(0, {}) end, { desc = "Reset loclist" })
map("n", "<Space>}", "<Cmd>lnext<CR>", { desc = "loclist next" })
map("n", "<Space>{", "<Cmd>lprevious<CR>", { desc = "loclist previous" })
map(
  "n",
  "<M-A>",
  function()
    local pos = vim.fn.getcurpos()
    vim.fn.setloclist(0, {
      {
        bufnr = vim.fn.bufnr(),
        lnum = pos[2],
        col = pos[3],
        text = vim.fn.getline(pos[2]),
        type = "",
      }
    }, "a")
  end,
  { desc = "setloclist" }
)

map("n", "<leader>ms", function()
  vim.cmd("mksession!")
  vim.notify(string.format("Session Saved: %s/Session.vim", vim.fn.getcwd()))
end, { silent = true, desc = "[Sessions] mksession" })

map("n", "<leader>lz", "<Cmd>Lazy<CR>", { desc = "Lazy" })
