{pkgs, ...}: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      iceberg-vim
      nerdtree
      haskell-vim
    ];
    extraConfig = ''
hi clear
set nocp
set encoding=utf-8
set guicursor=n-v-c-i:block-Cursor
let mapleader=" "
exec "nohlsearch"

syntax on
filetype plugin indent on

set number
set mouse=a
set showcmd
set path+=**
set wildmenu
set number
set hlsearch
set title
set showcmd
set showmode
set termguicolors

set incsearch
set ignorecase
set smartcase
set cursorline

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set scrolloff=5
set laststatus=2

" mappings
noremap J 5gj
noremap K 5gk
noremap H 5h
noremap L 5l

nmap ; :
nmap j gj
nmap k gk

map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k

map <LEADER>n :tabnew<CR>
map <LEADER>c :tabclose<CR>
map <LEADER>w :w<CR>
map <LEADER>q :q<CR>
map <LEADER>Q :q!<CR>

map <LEADER>uw :set wrap!<CR>
map <LEADER>ui4 :set tabstop=4<CR>:set softtabstop=4<CR>:set shiftwidth=4<CR>
map <LEADER>ui2 :set tabstop=2<CR>:set softtabstop=2<CR>:set shiftwidth=2<CR>

map [b :tabnext<CR>
map ]b :tabprev<CR>

set guicursor=n-v-c:block,i:ver25

nnoremap <leader>e :NERDTreeToggle<CR>

let g:lightline = { 'colorscheme': 'iceberg' }

set background=dark
silent! colorscheme iceberg
    '';
  };
}
