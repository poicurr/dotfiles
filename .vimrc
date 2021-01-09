set incsearch
set hlsearch
set smartcase
set wrapscan
set iminsert=0
set imsearch=-1
set cindent
set cino+=g0
set shiftwidth=2
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set expandtab
set relativenumber
set nu rnu
set nobackup
set noswapfile
set list
set listchars=tab:>-,extends:<,trail:-,eol:\  
set clipboard^=unnamed,unnamedplus
syntax enable
filetype plugin indent on
set completeopt-=preview

" ------------------------------------------------------------
" Key Mappings
" ------------------------------------------------------------
nnoremap <ESC><ESC> :nohlsearch<CR>

"-------------------------------------------------------------
" dein.vim
"-------------------------------------------------------------
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  let s:toml = '~/.vim/dein.toml'
  let s:lazy_toml = '~/.vim/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

"-------------------------------------------------------------
" NERDTree
"-------------------------------------------------------------
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable='▸'
let g:NERDTreeDirArrowCollapsible='▾'
let NERDTreeWinSize=20

" ---------------------------------------------
" Colorscheme
" ---------------------------------------------
set bg=dark
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox

let g:airline_theme = 'gruvbox'
" let g:airline_theme = 'violet'
" let g:airline_theme = 'molokai'

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
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline#extensions#branch#enabled = 1

filetype on

