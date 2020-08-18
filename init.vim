echo ">^.^<"

" Variables and Options ----- {{{
" =============

" Computer specific options
let g:python3_host_prog='C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python38\\python.exe'

" Set ripgrep for grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
" Always use system clipboard
set clipboard+=unnamedplus
" Set colorscheme
colorscheme torte
" Show incomplete commands
set showcmd
" Characters used for the `:list` command or 'list' option
set listchars=eol:$,tab:<->,trail:-,extends:>,precedes:<,nbsp:+
" <Tab> configuration
" See https://medium.com/@arisweedler/tab-settings-in-vim-1ea0863c5990 for a
" good explanation of the <Tab> configuration abstractions in Neovim
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8
set shiftround
" Enable more colors
set termguicolors
" Use smartcase for search
set ignorecase
set smartcase
" Break lines at word boundaries
set linebreak
" Do not unload buffers when abandoned
set hidden
" ----- }}}

" Plugins ----- {{{
" =======

call plug#begin()

" List of plugins
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" When installing LanguageClient-neovim for the first time, then `install.sh`
" or `install.ps1` should be executed to get the binaries.
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next',  }
Plug 'Shougo/deoplete.nvim'
call plug#end()
" ----- }}}

" LanguageClient-neovim ----- {{{
" =====================
let g:LanguageClient_serverCommands={
    \ 'rust': ['ra_lsp_server'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ }
let g:LanguageClient_autoStart=1
" ----- }}}

" deoplete ----- {{{
" ========
let g:deoplete#enable_at_startup=1
" ----- }}}

" Key mappings ----- {{{
" ============
" leader key
let mapleader=" "
" buffer local leader key
let maplocalleader=","

" edit this file
nnoremap <Leader>ev :edit $MYVIMRC<Enter>
" source this file
nnoremap <Leader>sv :source $MYVIMRC<Enter>
" 'very magic' search
nnoremap / /\v
nnoremap ? ?\v
" Language Client key mappings
function LanguageClient_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<Enter>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<Enter>
    nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<Enter>
    nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_references()<Enter>
    nnoremap <buffer> <silent> gc :call LanguageClient_contextMenu()<Enter>
  endif
endfunction
" ----- }}}

" Autocommands ----- {{{
" ============
augroup language_client
    autocmd!
    autocmd FileType * call LanguageClient_maps()
augroup END

augroup vim_folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" ----- }}}
