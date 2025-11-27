"" ------------------------------------------------------------
"" Basic Setup
"" ------------------------------------------------------------
"" --- Encoding ---
set encoding=utf-8 nobomb
set fileencoding=utf-8
set ff=unix

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

"" --- Available Commands ---
nnoremap <leader><leader> :Commands<CR>

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

"" --- Buffers ---
noremap <A-Left> :bprevious<CR>
noremap <A-Right> :bnext<CR>

"" --- Tabs ---
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" --- Terminal ---
function! OpenTerminal()
  botright terminal ++rows=8
endfunction
nnoremap <silent> <F5> :call OpenTerminal()<CR>

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

  call dein#add('Shougo/vimproc.vim', {'build': 'make'})

  call dein#add('dense-analysis/ale')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/asyncomplete-lsp.vim')
  call dein#add('rhysd/vim-lsp-ale')

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('airblade/vim-gitgutter')

  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0})
  call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})

  call dein#add('tomasiser/vim-code-dark')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('vim-airline/vim-airline')
call dein#end()

"" --- vimproc ---
let g:vimproc#download_windows_dll = 1

"" --- ale ---
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 0
let g:ale_completion_enabled = 0
let g:ale_set_balloons = 0
let g:ale_fix_on_save = 1
let g:ale_vim_vint_show_style_issues = 0
let g:ale_sh_shfmt_options = '-i 4'

let g:ale_fixers = {
  \  'c': ['clang-format'],
  \  'cpp': ['clang-format'],
  \  'javascript': ['prettier'],
  \  'typescript': ['prettier'],
  \  'typescriptreact': ['prettier'],
  \  'css': ['stylelint'],
  \  'python': ['black', 'yapf'],
  \  'rust': ['rustfmt'],
  \  'json': ['fixjson'],
  \  'sh': ['shfmt'],
  \  'lua': ['stylua'],
  \ }

let g:ale_linters = {
  \  'c': ['clang-tidy', 'vim-lsp'],
  \  'cpp': ['clang-tidy', 'vim-lsp'],
  \  'python': ['pylint', 'mypy', 'vim-lsp'],
  \  'javascript': ['eslint'],
  \  'typescript': ['eslint', 'vim-lsp'],
  \  'go': ['staticcheck', 'vim-lsp'],
  \  'rust': ['vim-lsp'],
  \  'lua': ['vim-lsp'],
  \ }

let g:ale_cpp_clangformat_options =
\  '--style="{BasedOnStyle: LLVM, AlwaysBreakTemplateDeclarations: Yes, IndentCaseLabels: true}"'
let g:ale_c_clangformat_options = g:ale_cpp_clangformat_options

highlight ALEErrorSign   guifg=#ff0000 guibg=#1e1e1e
highlight ALEWarningSign guifg=#ffff00 guibg=#1e1e1e
highlight ALEInfoSign    guifg=#00afff guibg=#1e1e1e
highlight ALEHintSign    guifg=#aaaaaa guibg=#1e1e1e

"" --- lsp ---
if executable('clangd')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd', '-background-index']},
    \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })
endif

if executable('typescript-language-server')
  " npm install -g tyepscript-language-server
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'tyepscript-language-server',
    \ 'cmd': { server_info -> ['typescript-language-server', '--stdio'] },
    \ 'allowlist': ['typescript', 'typescriptreact'],
    \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

autocmd User lsp_float_opened call popup_setoptions(
  \ lsp#ui#vim#output#getpreviewwinid(),
  \ {
  \   'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
  \   'highlight': 'NormalFloat',
  \ })

"" --- gitgutter ---
highlight GitGutterAdd          guifg=#00ff00 ctermfg=2 gui=bold cterm=bold
highlight GitGutterChange       guifg=#ffff00 ctermfg=3 gui=bold cterm=bold
highlight GitGutterDelete       guifg=#ff0000 ctermfg=1 gui=bold cterm=bold
highlight GitGutterChangeDelete guifg=#ff00ff ctermfg=5 gui=bold cterm=bold

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

"" --- nerdtree ---
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
""let g:NERDTreeDirArrowExpandable = '▸'
""let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeWinSize=25
let g:NERDTreeShowBookmarks=1

"" --- fugitive ---
set diffopt+=vertical

"" --- devicons ---
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1

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
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = '⚡'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1

"" --- FZF ---
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :NERDTreeClose<CR>:Rg<Space>
nnoremap <C-p> :NERDTreeClose<CR>:call FzfOmniFiles()<CR>

command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --vimgrep --hidden --color=always '.shellescape(<q-args>),
\ 1,
\ fzf#vim#with_preview({'options':
\   '--ansi --delimiter : --nth 4.. --preview-window=right:50%:nowrap:border'
\ }, 'right:50%', '?'),
\ <bang>0)

"" ---------------------------------------------
"" Visual Settings
"" ---------------------------------------------
"" --- Color ---
set background=dark
colorscheme codedark

"" --- Display ---
set nu rnu
set list
set listchars=tab:>-,extends:<,eol:\ ,trail:-
set ttyfast

"" --- Cursor ---
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[3 q"
set cursorline

"" --- FileType ---
augroup cppm_detect
  autocmd!
  autocmd BufNewFile,BufRead *.cppm setfiletype cpp
augroup END

filetype on

