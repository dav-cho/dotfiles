" Main -----------------------------------------------------

" Set run time paths and RC file run time path
" let $RTP=split(&runtimepath, ',')[0]
" let $RC="$HOME/.vim/vimrc"

set exrc
set noerrorbells
set belloff=all
set noswapfile

filetype plugin indent on
syntax on
set hidden
set noswapfile
set incsearch
set ignorecase
set smartcase
set termguicolors
set cmdheight=1
set mouse=a
set relativenumber
set number
set cursorline
set scrolloff=10
set sidescrolloff=10
set autoindent smartindent
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set nowrap
set hlsearch
set splitbelow
set splitright
setlocal path=.,**

" Vim-Plug -------------------------------------------------

" Automatic installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


" Set rtp to run ~/.vim/autoload
"set rtp+=~/.vim/autoload

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'ackyshake/Spacegray.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Colors --------------------------------------------------

"colorscheme spacegray
colorscheme gruvbox
"colorscheme onedark
"colorscheme dracula

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep = ''
"let g:airline_inactive_collapse=1
"let showtabline=2

"let g:airline_theme='deus'
let g:airline_theme='gruvbox'
"let g:airline_theme='bubblegum'
"let g:airline_theme='base16'
"let g:airline_theme='minimalist'
"let g:airline_theme='tomorrow'
"let g:airline_theme='simple'
"let g:airline_theme='wombat'
"let g:airline_theme='jellybeans'

"set background=dark
"highlight Normal guibg=none

highlight CursorLine ctermbg=none guibg=none
highlight CursorLineNr ctermfg=214 guifg=#FFAF00

"LineNr         xxx ctermfg=8 guifg=#3E4853 guibg=#111314
"LineNrAbove    xxx links to LineNr
"LineNrBelow    xxx links to LineNr

" Mappings -------------------------------------------------

let mapleader = ","

" Cursor Styles
let &t_SI.="\e[5 q" " SI = INSERT mode
let &t_SR.="\e[4 q" " SR = REPLACE mode
let &t_EI.="\e[2 q" " EI = NORMAL mode (ELSE)

nnoremap <silent> <leader>wr :w<CR>
nnoremap <silent> <leader>wa :wa<CR>
nnoremap <silent> <leader>bd :bd<CR>
nnoremap <silent> <leader>n :noh<CR>
nnoremap <silent> <leader>w <C-w>

nnoremap <silent> Y y$
vnoremap <silent> <leader>y "*y
nnoremap <silent> <leader>Y "*Y

