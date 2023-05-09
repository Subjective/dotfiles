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

" escape insert mode
inoremap jk <Esc>
inoremap kj <Esc>

" window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" buffers
nnoremap <Leader>n :enew<CR>
nnoremap <Leader>c :bd<CR>
nnoremap <Leader>b :buffers<CR>
nnoremap <Leader>w :w<CR>

" buffer navigation
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

" toggle netrw
nnoremap <Leader>e :Lex<CR>

" Plugin Configuration
let g:highlightedyank_highlight_duration = 250

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

" Hack fix to make ctrl-l work properly in netrw
autocmd filetype netrw noremap <buffer> <C-l> <C-w>l 
