local opt = vim.opt

-- opt.fileencoding = 'UTF-8'
opt.belloff = "all"
opt.mouse = "a"
opt.termguicolors = true
opt.swapfile = false

opt.cmdheight = 1
opt.pumheight = 10
opt.pumblend = 17
opt.wrap = false
-- opt.completeopt = { "menu", "menuone", "noselect" } -- Moved to completion.lua

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"

opt.scrolloff = 10
opt.sidescrolloff = 10

opt.splitright = true
opt.splitbelow = true

opt.formatoptions = vim.opt.formatoptions
  - "a" -- Automatic formatting of paragraphs. Every time text is inserted or deleted the paragraph will be reformatted. See |auto-format|. When the 'c' flag is present this only happens for recognized comments.
  - "t" -- Auto-wrap text using textwidth.
  + "c" -- Auto-wrap comments using textwidth, inserting the current comment leader automatically.
  + "q" -- Allow formatting of comments with "gq".Note that formatting will not change blank lines or lines containing only the comment leader. A new paragraph starts after such a line, or when the comment leader changes.
  + "n" -- When formatting text, recognize numbered lists. This actually uses the 'formatlistpat' option, thus any kind of list can be used. The indent of the text after the number is used for the next line. The default is to find a number, optionally followed by '.', ':', ')', ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work well together with "2".
  + "j" -- Where it makes sense, remove a comment leader when joining lines.
  + "r" -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
  - "o" -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
  - "2" -- When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph, instead of the indent of the first line.  This supports paragraphs in which the first line has a different indent than the rest.  Note that 'autoindent' must be set too. This also works inside comments, ignoring the comment leader.


-- TODO: Use treesitter for folding (see links below):
-- https://github.com/nvim-treesitter/nvim-treesitter#folding
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"


-- TODO:

-- Ignore compiled files
-- opt.wildignore = "__pycache__"
-- opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

-- Cool floating window popup menu for completion on command line
-- opt.pumblend = 17
-- opt.wildmode = "longest:full"
-- opt.wildoptions = "pum"

-- opt.showmode = false
-- opt.showcmd = true

-- opt.showmatch = true

-- opt.hidden = true
-- opt.equalalways = false

-- opt.hlsearch = true

-- opt.errorbells = false
-- opt.hidden = true
-- opt.timeoutlen = 100, -- default: 1000
-- opt.inccommand = 'nosplit'

-- opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
-- opt.linebreak = true

-- opt.fillchars = { eob = "~" }
