" Note to self: next time you install a new Python version, please remember to
"
" pip3 install --upgrade neovim
" and then
" :UpdateRemotePlugins
call plug#begin('~/.vim/plugged')
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
  Plug 'ayu-theme/ayu-vim'
  Plug 'tpope/vim-surround'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'mhinz/vim-startify'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'chr4/nginx.vim'
  Plug 'jpalardy/vim-slime'
  Plug 'tpope/vim-sleuth'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'tpope/vim-abolish'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
syntax on
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
:let mapleader = ","
set hidden
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

" -- NERDTree --
"
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>l :NERDTreeFind<CR>

"ALT-d / ALT-D split vertical / horizontal
nnoremap <A-d> <C-w>v
nnoremap <A-D> <C-w>s

" ALT-[arrows] move between splits
nnoremap <A-left> <C-w>h
nnoremap <A-down> <C-w>j
nnoremap <A-up> <C-w>k
nnoremap <A-right> <C-w>l

" -- FILES --
"
nmap <leader>b :Buffers<CR>
nmap <leader>ff :Files<CR>
nmap <leader>ag :Ag<CR>
" let g:ackprg = 'ag --nogroup --nocolor --column'

" -- EDITING --
"
" clear Highlights on enter
nnoremap <CR> :noh<CR><CR>

" replace the word under cursor with current clipboard 
:nmap <leader>r ciw<C-r>0<ESC>

" toggle scrollbind (remember to turn-on on each split)
nmap <leader>sb :set scrollbind!<CR>

" URL Encode and Decode selected text
vnoremap <leader>ue :%!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>ud :%!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

" JSON format selected text
vnoremap <leader>j :%!jq .<cr>

" -- GIT --
"
nmap <leader>di :Gdiffsplit<CR>
nmap <leader>st :Gstatus<CR>
nmap <leader>hif :GV!<CR>
nmap <leader>hi :GV<CR>


" Don't autoselect first autocomplete option; show options even if there is only one
set completeopt=longest,menuone


" -- Theme --
set termguicolors
let ayucolor="mirage"
colorscheme ayu


" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String


" FZF Floating
if has('nvim')
  let $FZF_DEFAULT_OPTS='--layout=reverse'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  function! FloatingFZF()
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)

    "Set the position, size, etc. of the floating window.
    "The size configuration here may not be so flexible, and there's room for further improvement.
    let opts = {
          \ 'relative': 'editor',
          \ 'row': height * 0.3,
          \ 'col': col + 30,
          \ 'width': width * 2 / 3,
          \ 'height': height / 2
          \ }

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    "Set Floating Window Highlighting
    call setwinvar(win, '&winhl', 'Normal:Pmenu')

    setlocal
          \ buftype=nofile
          \ nobuflisted
          \ bufhidden=hide
          \ nonumber
          \ norelativenumber
          \ signcolumn=no
  endfunction
end

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

" COC
let g:coc_global_extensions=[ 'coc-json', 'coc-tsserver', 'coc-omnisharp', 'coc-eslint' ]

" GOTO shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder ???
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

" Go Development
nmap <leader>gor :GoRun<CR>
nmap <leader>gob :GoBuild<CR>
