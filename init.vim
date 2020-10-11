echo ">^.^<"

" Variables and Options ----- {{{
" =============

" Set ripgrep for grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
" Always use system clipboard
set clipboard+=unnamedplus
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
set inccommand=split
" LSP
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" ----- }}}

" Plugins ----- {{{
" =======

call plug#begin()

" List of plugins
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'chriskempson/base16-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-lua/completion-nvim'

call plug#end()

" telescope.nvim
lua << EOF
require'telescope'.setup{
  defaults = {
    use_less = false,
  },
}
EOF

" ----- }}}

" Language Servers ----- {{{
" ================
lua require('nvim_lsp').clangd.setup{on_attach=require'completion'.on_attach}
lua <<EOF
require('nvim_lsp').sumneko_lua.setup{
    cmd = { "/path/to/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
            "-E", "/path/to/sumneko_lua/lua-language-server/main.lua" },
}
EOF
" ----- }}}

" Set colorscheme
colorscheme base16-ashes

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
" telescope.nvim
nnoremap <Leader>p <cmd>lua require'telescope.builtin'.find_files()<Enter>
nnoremap <Leader>tf <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<Enter>
nnoremap <Leader>tF <cmd>lua require'telescope.builtin'.live_grep()<Enter>
nnoremap <Leader>tc <cmd>lua require'telescope.builtin'.commands()<Enter>
nnoremap <Leader>tq <cmd>lua require'telescope.builtin'.quickfix()<Enter>
nnoremap <Leader>tl <cmd>lua require'telescope.builtin'.loclist()<Enter>
nnoremap <Leader>tb <cmd>lua require'telescope.builtin'.buffers()<Enter>
" LSP
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <Leader>la <cmd>lua require'telescope.builtin'.lsp_code_actions()<Enter>
nnoremap <Leader>li <cmd>lua vim.lsp.buf.implementation()<Enter>
nnoremap <Leader>lr <cmd>lua require'telescope.builtin'.lsp_references()<Enter>
nnoremap <Leader>l2 <cmd>lua vim.lsp.buf.rename()<Enter>
nnoremap <Leader>ld <cmd>lua vim.lsp.buf.declaration()<Enter>
nnoremap <Leader>lD <cmd>lua vim.lsp.buf.definition()<Enter>
nnoremap <Leader>lk <cmd>lua vim.lsp.buf.hover()<Enter>
nnoremap <Leader>ls <cmd>lua require'telescope.builtin'.lsp_document_symbols()<Enter>
nnoremap <Leader>lw <cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<Enter>
" ----- }}}

" Autocommands ----- {{{
" ============
augroup vim_folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" ----- }}}
