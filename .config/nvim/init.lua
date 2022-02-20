------------------------------ init.lua ------------------------------

--local cmd = vim.cmd  -- to execute vim commands e.g. cmd('pwd')
--local fn = vim.fn    -- to call vim functions e.g. fn.bufnr()
--local g = vim.g      -- a table to access global variables
--local opt = vim.opt  -- to set options

-------------------------------- Main --------------------------------

vim.g.mapleader = ','
vim.g.noerrorbells = true

vim.o.encoding = 'UTF-8'
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.swapfile = false

vim.o.breakindent = true
vim.o.cmdheight = 2
vim.o.completeopt = 'menuone,noselect'

vim.o.wrap = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.scrolloff = 10
vim.opt.showmode = false

--vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'

vim.opt.incsearch = true
vim.o.inccommand = 'nosplit'

vim.opt.termguicolors = true

--vim.opt.background = 'dark'
--vim.g.quantum_black = 1
--vim.g.quantum_italics = 1
--vim.cmd('colorscheme quantum')

vim.cmd('colorscheme jellybeans')
vim.g.jellybeans_overrides = {
  CursorLineNr = { guifg = 'FFB13B' }
}

--vim.g.codedark_conservative = 1
--vim.cmd('colorscheme codedark')

--vim.opt.background = 'dark'
--vim.cmd('colorscheme one')

--vim.opt.background = 'dark'
--vim.g.gruvbox_material_background = 'hard'    -- soft, medium, hard
--vim.g.gruvbox_material_enable_italic = 1
--vim.g.gruvbox_material_disable_italic_comment = 1
--vim.cmd('colorscheme gruvbox-material')
--
--vim.g.lightline = {}
--vim.g.lightline.colorscheme = 'gruvbox_material'

--vim.opt.background = 'dark'
--vim.g.everforest_background = 'hard'    -- soft, medium, hard
--vim.g.everforest_enable_italic = 1
--vim.g.everforest_disable_italic_comment = 1
--vim.cmd('colorscheme everforest')
--
--vim.g.lightline = {}
--vim.g.lightline.colorscheme = 'everforest'

--vim.g.edge_style = 'default'    -- default, aura, neon
--vim.g.edge_style = 'aura'    -- default, aura, neon
--vim.g.edge_enable_italic = 1
--vim.g.edge_disable_italic_comment = 1
--vim.cmd('colorscheme edge')
--
--vim.g.lightline = {}
--vim.g.lightline.colorscheme = 'edge'

--vim.g.sonokai_style = 'atlantis'
---- default, atlantis, andromeda, shusia, maia, espresso
--vim.g.sonokai_italic = 1
--vim.g.sonokai_disable_italic_comment = 1
--vim.cmd('colorscheme sonokai')
--
--vim.g.lightline = {}
--vim.g.lightline.colorscheme = 'sonokai'

--vim.opt.background = 'dark'
--vim.cmd('colorscheme PaperColor')

--vim.opt.background = 'dark'
--vim.cmd('colorscheme palenight')

--vim.g.material_theme_style = 'darker'
--vim.g.material_theme_style = 'default-community'
---- available options
---- default, palenight, ocean, lighter, darker,
---- default-community, palenight-community, ocean-community,
---- lighter-community, darker-community
--vim.cmd('colorscheme material')

--vim.opt.termguicolors = true
--vim.g.ayucolor="mirage"   -- light, mirage, dark
--vim.cmd('colorscheme ayu')

--vim.g.seoul256_background = 233
--vim.g.seoul256_background = 235
--vim.g.seoul256_background = 239
--vim.cmd('colorscheme seoul256')

--vim.opt.background = 'dark'
--vim.cmd('colorscheme pink-moon')

--vim.g.tokyonight_style = 'night' -- night, storm
--vim.g.tokyonight_enable_italic = 1
--vim.cmd('colorscheme tokyonight')

--vim.cmd('colorscheme janah')
--vim.cmd('colorscheme zenburn')
--vim.cmd('colorscheme yami')
--PhoenixRed, PhoenixBlue, PhoenixYellow
--PhoenixRedEighties, PhoenixBlueEighties, PhoenixYellowEighties

--vim.g.gruvbox_contrast_dark = 'soft'
--vim.g.gruvbox_contrast_dark = 'medium'
--vim.g.gruvbox_contrast_dark = 'hard'
--vim.cmd('colorscheme gruvbox')

--vim.cmd('colorscheme onedark')
--vim.cmd('colorscheme dracula')
--vim.cmd('colorscheme nord')
--vim.cmd('colorscheme minimalist')
--vim.cmd('colorscheme elly')
--vim.cmd('colorscheme phoenix')

--vim.cmd('colorscheme iceberg')
--vim.cmd('colorscheme onehalfdark')
--vim.g.lightline.colorscheme = 'onehalfdark'
--vim.opt.colors = 'zenburn'

--vim.cmd('colorscheme monokai')
--vim.cmd('colorscheme embark')
--vim.opt.background = 'dark'
--vim.cmd('colorscheme deus')
--vim.cmd('colorscheme hybrid_material')
--vim.cmd('colorscheme hybrid')
--vim.cmd('colorscheme afterglow')
--vim.cmd('colorscheme synthwave84')
--vim.cmd('colorscheme shades_of_purple')

vim.g.python3_host_prog = '~/.local/share/virtualenvs/neovim-venv-tlU6wFvh/bin/python'
--vim.env.VIRTUAL_ENV = '~/.local/share/virtualenvs/neovim-venv-tlU6wFvh/'

--vim.g.setexrc
--vim.opt.number = true
--vim.opt.hlsearch = false
--vim.opt.columns = 90
--vim.cmd('colorscheme onedark')
--vim.g.airline#extensions#tabline#enabled = 1

---- Vim Airline
--vim.g.airline.extensions.tabline.enabled = 1
--vim.api.nvim_set_var('airline')
--vim.g.airline#extensions#tabline#enabled = 1

---- TODO: Set truecolors (rewrite in lua)
--if (has("nvim"))
--  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
--  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
--endif
--
--"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
--"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
--" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
--if (has("termguicolors"))
--  set termguicolors
--endif

-------------------------------- Maps --------------------------------

---- Map Helpers
local function map(mode, before, after, opts)
  local options = { noremap = true }

  if opts then
    options = opts
  end

  vim.api.nvim_set_keymap(mode, before, after, options)
end

-- The function is called `t` for `termcodes`.
-- You don't have to call it that, but I find the terseness convenient
local function replace_termcodes(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---- Normal Mode
map('n', '0', '^')
map('n', '^', '0')
map('n', '<C-j>', '5j')
map('n', '<C-k>', '5k')
map('n', '<leader>w', '<C-w>')
map('n', '<leader>wr', '<cmd>w<CR>')
map('n', '<leader>n', '<cmd>noh<CR>')

---- Insert Mode
--map('i', 'JK', '<Esc>')
--map('i', '<M-ç>', '<Esc>')
--map('i', '<M-o>', '<Esc>o')
--map('i', '<M-[>', '<Esc>', { noremap = true, nowait = true })


---- Visual Mode
map('v', '0', '^')
map('v', '^', '0')
map('v', '<C-j>', '5j')
map('v', '<C-k>', '5k')

---- TODO: Move lines with opt j/k
--map('n', '<M-j>', '<cmd>m .+1<CR>')
--map('n', '<M-k>', '<cmd>m .-2<CR>')
--map('n', '<M-j>', '<Esc><cmd>m .+1<CR>==gi')
--map('n', '<M-k>', '<Esc><cmd>m .-2<CR>==gi')

---- TODO: Resize windows with <C-arrow>
--"<C-Up>", ":resize -2<CR>"
--"<C-Down>", ":resize +2<CR>"
--"<C-Left>", ":vertical resize -2<CR>"
--"<C-Right>", ":vertical resize +2<CR>"

---- TODO: Buffer Navigation
--replace_termcodes('<Tab>')
--map('n', '<C-Tab>', '<cmd>bnext<CR>')
--map('n', '<C-S-Tab>', '<cmd>bprev<CR>')
--map('n', '<C-M-l>', '<cmd>bnext<CR>')
--map('n', '<C-M-h>', '<cmd>bprev<CR>')

--map('n', '<leader>py', '<cmd>w !python<CR>')
--map('n', '<leader>pi', '<cmd>term python % <CR>')
--map('n', '<D-s>', '<cmd>w<CR>')
--map('n', '<leader>f', ':Black<CR>')

---- TODO: Autocomplete brackets
--map('i', '(', '()<Left)
--map('i', '[', '[]<Left>')
--map('i', '{', '{}<Left>')

---- LSP Autocomplete
---- TODO: move to compe.lua or lspconfig.lua?
local lsp_auto_opts = { expr = true }
map('i', '<Tab>', 'v:lua.tab_complete()', lsp_auto_opts)
map('s', '<Tab>', 'v:lua.tab_complete()', lsp_auto_opts)
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', lsp_auto_opts)
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', lsp_auto_opts)

------------------------------- davcho -------------------------------

require 'core'

-------------------------------- TODO --------------------------------

---- Plugins
-- https://github.com/windwp/nvim-autopairs
-- https://github.com/kyazdani42/nvim-tree.lua
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- https://github.com/kosayoda/nvim-lightbulb
-- https://github.com/lewis6991/gitsigns.nvim
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- https://github.com/edkolev/tmuxline.vim
-- https://github.com/iamcco/markdown-preview.nvim
-- https://github.com/folke/todo-comments.nvim
-- https://github.com/svermeulen/vimpeccable

---- Plugins for compe
-- https://github.com/GoldsteinE/compe-latex-symbols
-- https://github.com/andersevenrud/compe-tmux

---- Reload init.lua
--local config_path = "~/.config/nvim/init.lua"
map('n', '<F4>', '<cmd>lua package.loaded.plugins = nil <CR>:luafile ~/.config/nvim/init.lua<CR>')

--map('n', '<leader>fz', '<cmd>lua require("telescope.init").curr_buff()<CR>')

