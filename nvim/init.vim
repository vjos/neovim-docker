" vim mode
if &compatible
  set nocompatible
endif

" hybrid line numbers
set number relativenumber

" manage plugins with vim-plug
call plug#begin()
" core plugins to expand vim editing
Plug 'jiangmiao/auto-pairs' " inserts a matching closer for above pairs, handles indentation
Plug 'tpope/vim-commentary' " toggle code commenting with selection+gc or gcc
Plug 'tpope/vim-surround' " adds text-object like interactions for quotes, parens and tags [eg: cs'{]

" additional features outside of core editing
Plug 'Pocco81/TrueZen.nvim'
Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'numtostr/FTerm.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ziontee113/color-picker.nvim'

" handle code completion, linting and snippets
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'

" visual plugins
Plug 'RRethy/nvim-base16'
Plug 'ap/vim-css-color'
Plug 'bling/vim-bufferline'
Plug 'folke/twilight.nvim'
Plug 'itchyny/lightline.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'maximbaz/lightline-ale'
Plug 'unblevable/quick-scope'
call plug#end()

set shell=/bin/bash

" required for correct background window behaviour with shade and truezen
set hidden

" set the leader key (needs to be done before any leader key mappings are made)
nnoremap <SPACE> <Nop>
let mapleader=" "

" run init.lua script
lua require('init')
lua require('nvim-tree-conf')

" config that plugins depend on:
filetype plugin indent on
syntax enable
set tgc

" basic tab-spacing
set tabstop=4
set shiftwidth=4
set expandtab

" visual configs
set laststatus=3 "global status line (see https://www.youtube.com/watch?v=jH5PNvJIa6o)"
set noshowmode
set cursorline
set termguicolors
set wildmenu

" enable clipboard yank/paste
set clipboard+=unnamedplus

" remap emmet leader ctrl+e
let g:user_emmet_leader_key='<C-E>'

let g:lightline = {
  \ 'colorscheme': 'darcula',
  \}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \}

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \}

let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
	    \            [ 'percent' ],
	    \            [ 'fileformat', 'fileencoding', 'filetype'] ] }


let g:OmniSharp_server_use_mono = 1
let g:ale_linters = {
  \ 'cs': ['OmniSharp']
  \}

" tab, shift-tab and enter to control autocompletion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-Y>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

let g:coc_snippet_next = "<Tab>"
let g:coc_snippet_prev = "<S-Tab>"

" quick-scope config
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

colorscheme base16-darcula
highlight WinSeparator guibg=None

