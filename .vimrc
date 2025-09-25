"" ------------------------------------------------------------
"" Basic Setup
"" ------------------------------------------------------------
"" --- Encoding ---
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" --- Searching ---
set incsearch
set hlsearch
set smartcase
set wrapscan

set iminsert=0
set imsearch=-1
set cindent
set cino+=g0

"" --- Tabs ---
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set nu rnu
set nobackup
set noswapfile
set list
set listchars=tab:>-,extends:<,trail:-,eol:\ 

"" --- Copy/Paste/Cut ---
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"" --- Map leader to ',' ---
let mapleader=','

filetype plugin indent on
set completeopt-=preview
syntax enable

"" ------------------------------------------------------------
"" Cursor
"" ------------------------------------------------------------
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[3 q"

"" ------------------------------------------------------------
"" Key Mappings
"" ------------------------------------------------------------

nnoremap <ESC><ESC> :nohlsearch<CR>

"" --- Split ---
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" --- Switching windows ---
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l
noremap <C-Left> <C-w>h

"" --- Tabs ---
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

""-------------------------------------------------------------
"" Plugins(dein.vim)
""-------------------------------------------------------------
let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif

let s:dein_base = '~/.cache/dein/'
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' .. s:dein_src

call dein#begin(s:dein_base)
  call dein#add(s:dein_src)
  call dein#add('scrooloose/nerdtree')
  call dein#add('dense-analysis/ale')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('vim-airline/vim-airline')
  if executable('ag')
    call dein#add('rking/ag.vim')
  endif
call dein#end()

"" --- nerdtree ---
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable='▸'
let g:NERDTreeDirArrowCollapsible='▾'
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeWinSize=25
let g:NERDTreeShowBookmarks=1

"" --- ale ---
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let g:ale_fixers = {
\ 'c': ['clang-format'],
\ 'cpp': ['clang-format'],
\ 'javascript': ['prettier'],
\}

"" ---------------------------------------------
"" Visual Settings
"" ---------------------------------------------
set background=dark
colorscheme desert
set relativenumber
set cursorline
highlight CursorLine cterm=NONE ctermfg=white ctermbg=darkgray

"" ---------------------------------------------
"" airline
"" ---------------------------------------------
let g:airline_powerline_fonts = 1

let g:airline_theme = 'papercolor'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_skip_empty_sections = 1

filetype on
