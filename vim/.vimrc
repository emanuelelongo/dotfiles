" Note to self: next time you install a new Python version, please remember to
" pip3 install --upgrade neovim
" and then
" :UpdateRemotePlugins
call plug#begin('~/.vim/plugged')
	Plug '/usr/local/opt/fzf'
 	Plug 'junegunn/fzf.vim'
 	Plug 'scrooloose/nerdtree'
 	Plug 'editorconfig/editorconfig-vim'
 	Plug 'mileszs/ack.vim'
 	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer --rust-completer' }
 	Plug 'tpope/vim-commentary'
        Plug 'airblade/vim-gitgutter'
        Plug 'tpope/vim-fugitive'
 	Plug 'vim-airline/vim-airline'
 	Plug 'w0rp/ale'
 	Plug 'morhetz/gruvbox'
 	Plug 'tpope/vim-surround'
 	Plug 'pangloss/vim-javascript'
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
nmap <leader>b :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>g :Ag<CR>
nmap <leader>d :Gdiff<CR>
nmap <leader>s :Gstatus<CR>
nnoremap <CR> :noh<CR><CR>
nnoremap <F12> :YcmCompleter GoToDefinition<CR>
" if a PopUp Menu is visible then ESC close the menu and back to insert mode
inoremap <expr> <Esc> pumvisible() ? "\<Esc>a" : "\<Esc>"
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ackprg = 'ag --nogroup --nocolor --column'
" let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_linters = {'javascript': ['eslint']}
colorscheme gruvbox
set t_Co=256
set background=dark
" save the file (like w) as root
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String
" URL Encode and Decode
vnoremap <leader>en :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>de :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>
