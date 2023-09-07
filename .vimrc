" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'raimondi/delimitmate'
Plug 'justinmk/vim-sneak'
Plug 'jszakmeister/vim-togglecursor'
Plug 'machakann/vim-highlightedyank'

call plug#end()

" Options
syntax on
silent! colorscheme catppuccin_mocha
set number relativenumber
set termguicolors
set mouse=a
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cursorline
set signcolumn=yes
set ignorecase
set incsearch
set hlsearch
set showcmd
set belloff=all
set updatetime=100
set shm+=I
set fillchars+=eob:\ 

" leader and localleader keys
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
nnoremap <leader>n :enew<CR>
nnoremap <leader>c :confirm bdelete<CR>
nnoremap <leader>q :confirm quit<CR>
nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader>w :write<CR>

" buffer navigation
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap <leader>` :e #<CR>

" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fo :History<CR>
nnoremap <leader>fw :RG<CR>
nnoremap <leader>f/ :BLines<CR>
nnoremap <leader>fh :Helptags<CR>

" toggle netrw
nnoremap <leader>e :Lex<CR>

" yanking and pasting to system clipboard
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap Y y$
nnoremap <leader>Y "+y$

" delete and paste to black hole register
xnoremap <leader>p "_dP
nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <leader>D "_d$

" Plugin Configuration
let g:highlightedyank_highlight_duration = 250

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#s_next = 1

let g:delimitMate_expand_cr=1

" Hack fix to make ctrl-l work properly in netrw
autocmd filetype netrw noremap <buffer> <C-l> <C-w>l 
