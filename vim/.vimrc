call plug#begin('~/.vim/plugged')
	Plug '/usr/local/opt/fzf'
 	Plug 'junegunn/fzf.vim'
 	Plug 'scrooloose/nerdtree'
 	Plug 'editorconfig/editorconfig-vim'
 	Plug 'mileszs/ack.vim'
 	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
 	Plug 'tpope/vim-commentary'
 	Plug 'tpope/vim-fugitive'
 	Plug 'vim-airline/vim-airline'
 	Plug 'w0rp/ale'
 	Plug 'morhetz/gruvbox'
call plug#end()
syntax on
:let mapleader = ","
set nowrap
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set backspace=indent,eol,start
set autoindent
set copyindent
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set encoding=utf-8
set nobackup
set backupcopy=yes
set noswapfile
set mouse=a
set showcmd
set number
set noerrorbells
set clipboard=unnamed
set autoread
set diffopt+=vertical
let NERDTreeShowHidden=1
nmap <leader>l :NERDTreeFind<CR>
nmap <leader>t :NERDTreeToggle<CR>
nnoremap <CR> :noh<CR><CR>
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_linters = {'javascript': ['eslint']}
colorscheme gruvbox
set t_Co=256
set background=dark

