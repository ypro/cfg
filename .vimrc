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

" Navigate between tabs with Ctrl-h/Ctrl-l
nnoremap <C-h> :tabprev<CR>
nnoremap <C-l> :tabnext<CR>

" Hardcore mode ON
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>

" Use Ctrl+j/k for navigation in insert mode.
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" Highlight syntax
syntax on

" Always display a status line
set laststatus=2

""" My bindings
" Map Space as Leader key
let mapleader=" "

" Disable highlighting when Enter is pressed
nnoremap <CR> :noh<CR><CR>

" Invoke 'make'
nnoremap <Leader>m :make all -j40<CR>

" Open a new tab
nnoremap <Leader>t :tabnew<CR>

" Close window
nnoremap <Leader>q :q<CR>

""" Quickfix bindings
" Open Quickfix if there are errors, close otherwise
nnoremap <Leader>cc :cwindow<CR>

" Close Quickfix window
nnoremap <Leader>cd :cclose<CR>
" Next error
nnoremap <Leader>cn :cnext<CR>
" Previous error
nnoremap <Leader>cp :cprev<CR>

""" Lsp key binding
" Show declaration
nnoremap <Leader>ld :LspDeclaration<CR>
" Show declaration in preview window
nnoremap <Leader>lc :LspPeekDeclaration<CR>
" Show definition
nnoremap <Leader>lf :LspDefinition<CR>
" Show definition in new window
nnoremap <Leader>lv :LspPeekDefinition<CR>
" Show references
nnoremap <Leader>lr :LspReferences<CR>
" Show type definition
nnoremap <Leader>lt :LspTypeDefinition<CR>
" Show type hierarchy
nnoremap <Leader>lh :LspTypeHierarchy<CR>
" Jump to next error
nnoremap <Leader>ln :LspNextError<CR>
" Jump to previous error
nnoremap <Leader>lp :LspPreviousError<CR>

""" Local vimrc settings
" Load the closest .lvimrc
let g:localvimrc_count=1
" Don't ask before sourcing .lvimrc
let g:localvimrc_ask=0

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 3

""" vim-lsp logging
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
""""""""""""""""""""""""
""" Configure Vundle plugin manager """
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

" Fugitive git plugin
Plugin 'tpope/vim-fugitive'

""" LSP support
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/vim-lsp'

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

" No file number limit
let g:ctrlp_max_files = 0

""" Color scheme
set termguicolors
"colorscheme solarized8
colorscheme gruvbox

""" LSP support
" Register Clangd-9 if present
if executable('clangd-mp-9.0')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->[
               \ 'clangd-mp-9.0',
               \ '-background-index',
               \  '-log=info',
               \ '--query-driver=/usr/bin/c++']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if executable('clangd-9')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->[
               \ 'clangd-9',
               \ '-background-index',
               \  '-log=info',
               \ '--query-driver=/usr/bin/c++']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" Configure vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
