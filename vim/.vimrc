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
        Plug 'junegunn/gv.vim'
 	Plug 'vim-airline/vim-airline'
 	Plug 'w0rp/ale'
 	Plug 'morhetz/gruvbox'
 	Plug 'tpope/vim-surround'
 	Plug 'pangloss/vim-javascript'
 	Plug 'mxw/vim-jsx'
        Plug 'mhinz/vim-startify'
        Plug 'mustache/vim-mustache-handlebars'
        Plug 'ervandew/supertab'
        Plug 'chr4/nginx.vim'
        Plug 'OmniSharp/omnisharp-vim'
        Plug 'jpalardy/vim-slime'
call plug#end()
syntax on
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
:let mapleader = ","
set nowrap
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set backspace=indent,eol,start
set sidescroll=1
set autoindent
set copyindent
set showmatch
set ignorecase
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
set hid
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
"Moving between splits by ALT+Arrows
nnoremap <A-Left> <C-w>h
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
nnoremap <A-Right> <C-w>l
"Split vertical ALT+d and horizontal ALT+D
nnoremap <A-d> <C-w>v
nnoremap <A-D> <C-w>s
nnoremap <A-w> <Esc>:q<CR>
map <C-L> 20zl " Scroll 20 characters to the right
map <C-H> 20zh " Scroll 20 characters to the Left
nmap <leader>l :NERDTreeFind<CR>
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>a :Ack!<space>
nmap <leader>g :Ag<CR>
nmap <leader>d :GdiffInTab<CR>
nmap <leader>s :Gstatus<CR>
nmap <leader>h :GV<CR>
nmap <leader>hf :GV!<CR>
nmap <leader>q :tabclose<CR>
nmap <Tab> :Buffers<CRnmap <Tab> :Buffers<CR>>
nnoremap <CR> :noh<CR><CR>
nnoremap <F12> :YcmCompleter GoToDefinition<CR>
" CTRL-j replace the word under cursor with current clipboard 
:map <C-j> ciw<C-r>0<ESC>
" if a PopUp Menu is visible then ESC close the menu and back to insert mode
" inoremap <expr> <Esc> pumvisible() ? "\<Esc>a" : "\<Esc>"
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ale_fixers = {'javascript': ['eslint']}
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
command GdiffInTab tabedit %|Gdiff
" Makes so that Ag accepts arguments (ex: find in js: Ag -G'\.js$' textToSearch)
function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
endfunction
autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>/

:set foldmethod=syntax
let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_prefer_global_sln = 1

" CTRL-C CTRL-C send current selection to a REPL on a terminal inside vim
" to open a terminal inside vim type :terminal
" you will be asked the jobid to identify the terminal
" the jobid is the number shown in the section_b of airline
let g:slime_target = "neovim"
let g:airline_section_b = '%{exists("b:terminal_job_id")?b:terminal_job_id: ""}'

