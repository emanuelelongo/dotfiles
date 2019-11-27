call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-commentary'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'ayu-theme/ayu-vim'
  Plug 'tpope/vim-surround'
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'mhinz/vim-startify'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'chr4/nginx.vim'
  Plug 'jpalardy/vim-slime'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-abolish'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:coc_global_extensions=[ 'coc-json', 'coc-tsserver', 'coc-omnisharp', 'coc-eslint', 'coc-lists', 'coc-tslint-plugin' ]

syntax on
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
:let mapleader = ","
set hidden

" make trailing spaces, eol and tabs visible
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
set nowritebackup
set noswapfile
set mouse=a
set showcmd
set number
set noerrorbells
set clipboard=unnamed
set autoread
set diffopt+=vertical
set cmdheight=2
set signcolumn=yes
set shortmess+=c
" Don't autoselect first autocomplete option; show options even if there is only one
set completeopt=longest,menuone

" -- NERDTree --
"
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>T :NERDTreeFind<CR>

" SPLITS:
" Rationale
" Splitting and moving between splits is a mildly frequent operation so the
" shortcuts has to be fast to type (single keypress).
" However they are operations that changes the working context so it is
" acceptable to use a far away key to activate them (ALT).

"ALT-d / ALT-D split vertical / horizontal
nnoremap <A-d> <C-w>v
nnoremap <A-D> <C-w>s
nnoremap <A-w> :q<CR>
nnoremap <A-q> :qa<CR>

" ALT-[arrows] move between splits
nnoremap <A-left> <C-w>h
nnoremap <A-down> <C-w>j
nnoremap <A-up> <C-w>k
nnoremap <A-right> <C-w>l

" -- FILES --
"
" Show open buffers
nmap <leader>b :CocList buffers<CR>
" Fuzzy search file names
nmap <leader>lf :CocList files<CR>
" Fuzzy grep in files
nmap <leader>lg :CocList grep<CR>
" Fuzzy search Lines in current file
nmap <leader>ll :CocList lines<CR>
" Fuzzy search in searchhistory
nmap <leader>ls :CocList searchhistory<CR>

" -- EDITING --
"
" Clear highlights when enter pressed
nnoremap <CR> :noh<CR><CR>

" Replace the word under cursor with current clipboard 
:nmap <leader>r ciw<C-r>0<ESC>

" URL Encode and Decode selected text
vnoremap <leader>ue :%!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>ud :%!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

" JSON format selected text
vnoremap <leader>j :%!jq .<cr>

" -- GIT --
"
" git diff of current file
nmap <leader>di :Gdiffsplit<CR>
" git status
nmap <leader>st :Gstatus<CR>
" git log
nmap <leader>hi :GV<CR>
" git log of current file
nmap <leader>hif :GV!<CR>

" -- STARTIFY --
"  when opening file from startify, preserve CWD
let g:startify_change_to_dir = 0
"  ...or if the file is under VCS go to VCS root
let g:startify_change_to_vcs_root = 1

" -- THEME --
"
set termguicolors
let ayucolor="mirage"
colorscheme ayu

" -- REPL --
"
if has('nvim')
  " CTRL-C CTRL-C send current selection to a REPL on a terminal inside vim
  " to open a terminal inside vim type :terminal
  " you will be asked the jobid to identify the terminal
  " the jobid is the number shown in the section_b of airline
  let g:slime_target = "neovim"
  let g:airline_section_b = '%{exists("b:terminal_job_id")?b:terminal_job_id: ""}'
endif

" -- CODING --
"
" Comment style for typescript - doesn't work :(
autocmd FileType typescript setlocal commentstring=//\ %s

" GOTO shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Format
nmap <leader>m :Format<CR>

" CTRL-SPACE to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" TAB for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" K to show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" F2 to rename
nmap <F2> <Plug>(coc-rename)

" Overwrite default formatting for selected text
xmap = <Plug>(coc-format-selected)
nmap = <Plug>(coc-format-selected)

augroup cocstuffs
  autocmd!
  " use coc to format javascript, typescript and json
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder (wtf ???)
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" CodeAction
nmap <leader><space> <Plug>(coc-codeaction)
xmap <leader><space> <Plug>(coc-codeaction-selected)

" AutoFix problem of current line
nmap <F3> <Plug>(coc-fix-current)

" CTRL-d progressive selection range
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

