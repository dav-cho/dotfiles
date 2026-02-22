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

-- opt.nrformats:append("alpha", "unsigned")

-- TODO: shada=!,'100,<50,s10,h
--     default=!,'100,<50,s10,h
-- opt.shada:append({ "" })

-- opt.guicursor="n-v-c-sm:block-Cursor,i-ci-ve:ver25-blinkon500-blinkoff500,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
-- opt.guicursor="n-v-c-sm:block-Cursor,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor,a:blinkwait100-blinkon500-blinkoff500"
