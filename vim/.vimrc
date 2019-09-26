" Note to self: next time you install a new Python version, please remember to
"
" pip3 install --upgrade neovim
" and then
" :UpdateRemotePlugins
call plug#begin('~/.vim/plugged')
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'mileszs/ack.vim'
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
  Plug 'jpalardy/vim-slime'
  Plug 'tpope/vim-sleuth'
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
syntax on
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
:let mapleader = ","
let g:deoplete#enable_at_startup = 1
set list
set listchars+=trail:•,eol:¬,tab:▸∙
set nowrap
au BufRead,BufNewFile *.md setlocal textwidth=80
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

" Moving between splits by ALT-hjkl
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"Split vertical ALT-d and horizontal ALT+D
nnoremap <A-d> <C-w>v
nnoremap <A-D> <C-w>s

"Alt-W close buffer 
nnoremap <A-w> <Esc>:q<CR>

" Leader 
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>l :NERDTreeFind<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>ff :Files<CR>
nmap <leader>ack :Ack!<space>
nmap <leader>ag :Ag<CR>
nmap <leader>di :GdiffInTab<CR>
nmap <leader>st :Gstatus<CR>
" replace the word under cursor with current clipboard 
:nmap <leader>j ciw<C-r>0<ESC>

" git HIstory
nmap <leader>hi :GV<CR>

" git HIstory for current File
nmap <leader>hif :GV!<CR>

" close tab
nmap <leader>q :tabclose<CR>

" clear Highlights on enter
nnoremap <CR> :noh<CR><CR>

" toggle scrollbind (remember to turn-on on each split)
nmap <leader>sb :set scrollbind!<CR>

" Don't autoselect first autocomplete option; show options even if there is only one
set completeopt=longest,menuone

let g:ackprg = 'ag --nogroup --nocolor --column'
" ALE
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_linters = {'javascript': ['eslint'], 'cs': ['OmniSharp'] }

" Theme
colorscheme gruvbox
set t_Co=256
set background=dark

" write down current buffer as root
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

" URL Encode and Decode
vnoremap <leader>ue :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>ud :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

command GdiffInTab tabedit %|Gdiff

" Makes Ag accepts arguments (ex: find in js: Ag -G'\.js$' textToSearch)
function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
endfunction
autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)

if has('nvim')
  " CTRL-C CTRL-C send current selection to a REPL on a terminal inside vim
  " to open a terminal inside vim type :terminal
  " you will be asked the jobid to identify the terminal
  " the jobid is the number shown in the section_b of airline
  let g:slime_target = "neovim"
  let g:airline_section_b = '%{exists("b:terminal_job_id")?b:terminal_job_id: ""}'
endif

" supertab integration with omnisharp
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

" OmniSharp
" use stdio instead of http
let g:OmniSharp_server_stdio = 1

" rename
nnoremap <F2> :OmniSharpRename<CR>

augroup omnisharp_commands
  autocmd!
  " Show type information automatically when the cursor stops moving
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  " Go To Definition / Implementation
  autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>gi :OmniSharpFindImplementations<CR>
  
  " Find symbol (use fzf)
  autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
  
  " Find usages
  autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
  
  " Move bwtween methods / classes 
  autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
  autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>

  " Actions available based on position
  autocmd FileType cs nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
  autocmd FileType cs xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
augroup END

" Go Development
nmap <leader>gor :GoRun<CR>
nmap <leader>gob :GoBuild<CR>


inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" MacVim require some fix
if has("gui_macvim")

  set guifont=Monaco:h14
  
  " Moving between splits by ALT-hjkl
  nnoremap ∆ <C-w>h
  nnoremap ª <C-w>j
  nnoremap º <C-w>k
  nnoremap ¬ <C-w>l

  "Split vertical ALT-d and horizontal ALT+D
  noremap ∂ <C-w>v
  nnoremap ˘ <C-w>s

  function! GuiTabLabel()
    return substitute( expand( '%:p' ), '.\+\/\(.\+\)\/.\+', '\1', '' )
  endfunction
  set guitablabel=%{GuiTabLabel()}


  " Ctrl-Tab and Shift-Ctrl-Tab switch between open tabs
  noremap <C-Tab> :tabnext<CR>
  noremap <C-S-Tab> :tabprev<CR>

  " Switch to specific tab numbers with Command-number
  noremap <D-1> :tabn 1<CR>
  noremap <D-2> :tabn 2<CR>
  noremap <D-3> :tabn 3<CR>
  noremap <D-4> :tabn 4<CR>
  noremap <D-5> :tabn 5<CR>
  noremap <D-6> :tabn 6<CR>
  noremap <D-7> :tabn 7<CR>
  noremap <D-8> :tabn 8<CR>
  noremap <D-9> :tabn 9<CR>
endif

