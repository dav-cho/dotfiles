local opt = vim.opt

opt.breakindent = true
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.diffopt:append({ "vertical" })
opt.expandtab = true
opt.formatoptions = "jncrql"
opt.ignorecase = true
opt.inccommand = "split"
opt.linebreak = true
opt.mouse = "a"
opt.nrformats:append("unsigned")
opt.number = true
opt.pumblend = 10
opt.pumheight = 15
opt.relativenumber = true
opt.scrolloff = 1
opt.sessionoptions:append("globals")
opt.shiftwidth = 2
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.wrap = false
