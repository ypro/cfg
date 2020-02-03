""" Generic configs """

" We love the dark
set background=dark

" Use ViM
set nocompatible

" Highlight cursor line
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=4 guibg=Cyan

" Incremental search
set incsearch

" Highlight search patterns
set hlsearch

" Search case insensetive
set ignorecase

" Override 'ignorecase' when search pattern contains upper case char.
set smartcase

" Use mouse
set mouse=a

" Display line numbers
set number

" Display trailing spaces and tabs
set list listchars=tab:>.,trail:.

""" Navigation and tabs
" Open new tab with Ctrl-T
" nnoremap <C-t> :tabnew<CR>

""" Use ag for Ctrl-P plugin
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

""" Use cscope
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

" Toggle line numbers with C-n
map <C-n> :set number!<CR>
" Toggle non-printable characters with C-N
map <C-N> :set list!<CR>

" Navigate between tabs with Ctrl-h/Ctrl-l
nnoremap <C-h> :tabprev<CR>
nnoremap <C-l> :tabnext<CR>

" Hardcore mode ON
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>

" Highlight syntax
syntax on

" Always display a status line
set laststatus=2

" This is for my Mac: map § to ESC
inoremap § <ESC>

" Load the closest .lvimrc
let g:localvimrc_count=1
" Don't ask before sourcing .lvimrc
let g:localvimrc_ask=0
""""""""""""""""""""""""
""" Configure Vundle """
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" CtrlP plugin
Plugin 'ctrlpvim/ctrlp.vim'

" Color schemes
Plugin 'lifepillar/vim-solarized8'
Plugin 'morhetz/gruvbox'

" Local vim configs (.lvimrc)
Plugin 'embear/vim-localvimrc'

call vundle#end()            " required
filetype plugin indent on    " required

""" Configure CtrlP
" Show up to 80 results
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:80'
" Configure cache
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '/data/cache/ctrlp'
" Open multiple files in new tabs
let g:ctrlp_open_multiple_files = 'tjr'
" Search by filename by default
let g:ctrlp_by_filename = 1

""" Color scheme
set termguicolors
"colorscheme solarized8
colorscheme gruvbox

