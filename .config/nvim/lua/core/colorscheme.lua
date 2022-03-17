-- TODO: Move to 'lua/themes/neovim'? Each in their own file like lualine themes?


----- Dark+ -----

vim.g.transparent_background = true

-- TODO: Override defautl setup?
--local ok, default_highlights = pcall(require, 'darkplus.highlights')
--if not ok then
--  vim.notify('~ Dark+ Call Error!')
--end
--
--highlights = {
--  SignColumn = { guibg = 'none' },
--  CursorLine = { guibg = 'none' },
--  CursorLineNr = { guifg = '#FFB13B' },
--}
--
--default_highlights = vim.tbl_deep_extend('force', default_highlights, highlights)

local colorscheme = "darkplus"

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
  vim.notify('~ Colorscheme ' .. colorscheme .. ' not found!')
  return
end

vim.cmd 'highlight SignColumn guibg=none'
vim.cmd 'highlight CursorLine guibg=none'
vim.cmd 'highlight CursorLineNr guifg=#FFB13B'


----- Tokyo Night -----

--vim.g.tokyonight_transparent = true
--vim.g.tokyonight_transparent_sidebar = true
--
--local colorscheme = 'tokyonight'
--
--local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
--if not ok then
--  vim.notify('~ Colorscheme ' .. colorscheme .. ' not found!')
--  return
--end


----- Material -----

--vim.g.material_style = 'darker'
--
--local ok, material = pcall(require, 'material')
--if not ok then
--  vim.notify('~ Material Call Error!')
--  return
--end
--
--material.setup({
--	contrast = {
--		sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
--	},
--	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
--		"terminal", -- Darker terminal background
--	},
--	disable = {
--    background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
--		--term_colors = true, -- Prevent the theme from setting terminal colors
--	},
--  lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
--  custom_highlights = {
--    CursorLine = { guibg = 'none' }
--    --  CursorLineNr = { guifg = 'FFB13B' },
--    --  background = { ctermbg = 'none', guibg= 'none' },
--    --  SignColumn = { ctermbg = 'none', guibg= 'none' },
--  }
--})
--
--
--local colorscheme = 'material'
--
--local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
--if not ok then
--  vim.notify('~ Colorscheme ' .. colorscheme .. ' not found!')
--  return
--end


----- Jellybeans -----

--vim.g.jellybeans_overrides = {
--  CursorLineNr = { guifg = 'FFB13B' },
--  background = { ctermbg = 'none', guibg= 'none' },
--  SignColumn = { ctermbg = 'none', guibg= 'none' },
--}

--vim.api.nvim_exec(
--[[
--if has('termguicolors') && &termguicolors
--    let g:jellybeans_overrides['background']['guibg'] = 'none'
--endif
--]]
--false)

--local colorscheme = 'jellybeans'

--local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
--if not ok then
--  vim.notify('~ Colorscheme ' .. colorscheme .. ' not found!')
--  return
--end


-- TODO: need?
--vim.g.CursorLineNr = { guifg = 'FFB13B' }
--vim.g.background = { ctermbg = 'none', guibg= 'none' }
--vim.g.SignColumn = { ctermbg = 'none', guibg= 'none' }

