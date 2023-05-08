" Plugins
call plug#begin()

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'raimondi/delimitmate'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'

call plug#end()

" Options
syntax on
colorscheme catppuccin_mocha
set number relativenumber
set termguicolors
set clipboard=unnamed
set mouse=a
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cursorline
set ignorecase
set incsearch
set hlsearch
set belloff=all
set updatetime=100

" Vertical Cursor Line in Insert Mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

let mapleader = " "
let maplocalleader = "\\"

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Leader>n :enew<CR>
nnoremap <Leader>c :bd<CR>
nnoremap <Leader>b :buffers<CR>

nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

nnoremap <Leader>e :Lex<CR>:vertical resize 30%<CR>

" Plugin Configuration
let g:highlightedyank_highlight_duration = 250
