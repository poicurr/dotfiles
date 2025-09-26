"" ------------------------------------------------------------
"" Basic Setup
"" ------------------------------------------------------------
"" --- Encoding ---
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" --- Searching ---
set incsearch
set hlsearch
set smartcase
set wrapscan

"" --- Tabs ---
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

"" --- IME ---
set iminsert=0
set imsearch=-1

"" --- Indent ---
set cindent
set cino+=g0

"" --- Backspace/Cursor Movement ---
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

"" --- Prevents unnecessary file generation ---
set nobackup
set noswapfile

"" --- Copy/Paste/Cut ---
set clipboard=unnamed,unnamedplus

filetype plugin indent on
syntax enable

"" ------------------------------------------------------------
"" Key Mappings
"" ------------------------------------------------------------
let mapleader=','

"" --- Clear search results ---
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

"" --- airline ---
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_theme = 'papercolor'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1

"" ---------------------------------------------
"" Visual Settings
"" ---------------------------------------------
"" --- Color ---
set background=dark
colorscheme default
if has('termguicolors')
  set termguicolors
endif

highlight Normal       guifg=#D4D4D4 guibg=#1E1E1E ctermfg=252 ctermbg=235
highlight Comment      guifg=#6A9955                     ctermfg=65
highlight String       guifg=#CE9178                     ctermfg=173
highlight Number       guifg=#B5CEA8                     ctermfg=151
highlight Keyword      guifg=#569CD6                     ctermfg=75
highlight Identifier   guifg=#9CDCFE                     ctermfg=117
highlight Function     guifg=#DCDCAA                     ctermfg=187
highlight Type         guifg=#4EC9B0                     ctermfg=79
highlight Constant     guifg=#569CD6                     ctermfg=75
highlight Special      guifg=#C586C0                     ctermfg=176
highlight Operator     guifg=#D4D4D4                     ctermfg=252
highlight Error        guifg=#F44747 guibg=#1E1E1E       ctermfg=203 ctermbg=235
highlight Search       guibg=#264F78 guifg=NONE          ctermbg=24  ctermfg=NONE
highlight LineNr       guifg=#858585 guibg=#1E1E1E       ctermfg=240 ctermbg=235
highlight CursorLineNr guifg=#FFFFFF guibg=#1E1E1E gui=bold ctermfg=15 ctermbg=235 cterm=bold
highlight CursorLine   guibg=#2A2A2A gui=NONE            ctermbg=236 cterm=NONE

"" --- Display ---
set nu rnu
set list
set listchars=tab:>-,extends:<,trail:-,eol:\ 
set ttyfast

"" --- Cursor ---
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[3 q"
set cursorline

filetype on

