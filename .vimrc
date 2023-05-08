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

" Vertical Cursor Line in Insert Mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Mappings
inoremap jk <Esc>
inoremap kj <Esc>

" Plugin Configuration
let g:highlightedyank_highlight_duration = 250
