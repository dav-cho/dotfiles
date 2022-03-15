----- Dark+ -----

local colorscheme = "darkplus"

vim.g.transparent_background = true

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  vim.notify('~ Colorscheme ' .. colorscheme .. ' not found!')
  return
end

vim.cmd 'highlight SignColumn guibg=none'
vim.cmd 'highlight CursorLine guibg=none'
vim.cmd 'highlight CursorLineNr guifg=#FFB13B'


----- Tokyo Night -----

--local colorscheme = 'tokyonight'
--
--vim.g.tokyonight_transparent = true
--vim.g.tokyonight_transparent_sidebar = true
--
--local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
--if not status_ok then
--  vim.notify('~ Colorscheme ' .. colorscheme .. ' not found!')
--  return
--end


----- Jellybeans -----

--local colorscheme = 'jellybeans'

--vim.g.jellybeans_overrides = {
--  CursorLineNr = { guifg = 'FFB13B' },
--  background = { ctermbg = 'none', guibg= 'none' },
--  SignColumn = { ctermbg = 'none', guibg= 'none' },
--  --background = { ctermbg = 'none', 256ctermbg = 'none' },
--  --SignColumn     xxx ctermfg=14 ctermbg=242 guifg=#777777 guibg=#333333
--}

--vim.api.nvim_exec(
--[[
--if has('termguicolors') && &termguicolors
--    let g:jellybeans_overrides['background']['guibg'] = 'none'
--endif
--]]
--false)

-- TODO: need?
--vim.g.CursorLineNr = { guifg = 'FFB13B' }
--vim.g.background = { ctermbg = 'none', guibg= 'none' }
--vim.g.SignColumn = { ctermbg = 'none', guibg= 'none' }

