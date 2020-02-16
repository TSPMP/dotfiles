" Plugins
" =======

" Plugins will be downloaded under the specified directory
call plug#begin('~/.local/share/nvim/plugged/')

" List of plugins
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" When installing LanguageClient-neovim for the first time, then `install.sh`
" or `install.ps1` should be executed to get the binaries.
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next',  }
Plug 'Shougo/deoplete.nvim'
"TODO enable this after LSP is natively supported in NeoVim
"Plug 'neovim/nvim-lsp'
"Plug 'Shougo/deoplete-lsp'

call plug#end()

" nvim-lsp 
" ========
"TODO enable this after LSP is natively supported in NeoVim
"lua require'nvim_lsp'.rust_analyzer.setup({})

" LanguageClient-neovim
" =====================
let g:LanguageClient_serverCommands={
    \ 'rust': ['ra_lsp_server'],
    \ 'cpp': ['clangd'],
    \ }
"let g:LanguageClient_autoStart=1

" deoplete
" ========
let g:deoplete#enable_at_startup=1

" Key mappings
" ============
function LanguageClient_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_references()<CR>
    nnoremap <buffer> <silent> gc :call LanguageClient_contextMenu()<CR>
  endif
endfunction

autocmd FileType * call LanguageClient_maps()

" Miscellaneous
" =============

" Set ripgrep for grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
" Always use system clipboard
set clipboard+=unnamedplus
" Set colorscheme
colorscheme peachpuff
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
" Enable more colors
set termguicolors
" Use smartcase for search
set smartcase
