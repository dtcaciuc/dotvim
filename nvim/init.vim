let sitedir = stdpath("data")."/site"

let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if !filereadable(sitedir.'/autoload/plug.vim')
  exec '!curl -fLo '.sitedir.'/autoload/plug.vim --create-dirs '.plugurl
  finish
endif

call plug#begin(sitedir.'/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

Plug 'clojure-lsp/clojure-lsp'

" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/nvim-cmp'

" Colors
Plug 'yorickpeterse/vim-paper'
Plug 'robertmeta/nofrils'
Plug 'ramojus/mellifluous.nvim'
call plug#end()

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" Move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

" Edit a file in the same directory as the current buffer.
" This leaves the prompt open, allowing Tab expansion or manual completion.
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Enter directory listing for the directory of the current buffer
map <leader>. :e %:p:h<CR>
" Create a new window with directory listing of current buffer
map <leader>wn :new %:p:h<CR>
" Change global directory to the current directory of the current buffer
map <leader>cd :cd %:p:h<CR>
" Match trailing whitespace
nmap <silent> ,mw :match Todo /\s\+$/<cr>
" Remove trailing whitespace
nmap <silent> ,rw :%s/\s\+$//<cr>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

set encoding=utf-8              " Necessary to show unicode glyphs
set wildmode=longest:full,full  " Don't autocomplete on first tab on cmdline
set smartindent
set number
set nowrap
set wildmenu                    " visual autocomplete for command menu
set acd

set scrolloff=5                 " scrolling begins at 5th line from top or bottom

set nobackup
set noswapfile
set expandtab

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set textwidth=120

set clipboard=unnamedplus

" fast save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

" Saves the position of screen at exit
autocmd BufWinLeave *.* mkview

" Restores screen last position
autocmd BufWinEnter *.* silent! loadview

autocmd BufNewFile,BufRead *.heex set ft=eelixir
autocmd BufWritePre *.ex,*.exs,*.heex,*.py,*.tf,*.tfvars,*tfbackend lua vim.lsp.buf.format()

let g:airline_symbols_ascii = 1
let g:airline#extensions#nvimlsp#enabled = 1

let g:go_fmt_command = 'gopls'

function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/nvim.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction

" LSP config
lua require "init_lsp"
lua require "init_treesitter"

" Exilir
hi link elixirAlias none
hi link elixirOperator none
hi def link elixirStringDelimiter String
hi Comment guifg=#a98a70

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({ cwd = vim.lsp.buf.list_workspace_folders()[1] })<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep({ cwd = vim.lsp.buf.list_workspace_folders()[1] })<cr>

if exists("g:neovide")
    " colorscheme peachpuff
    " colorscheme mellifluous
    " colorscheme nofrils-light
    colorscheme paper

    let g:airline_theme='atomic'

    let g:neovide_scroll_animation_length = 0.1
    let g:neovide_cursor_animation_length=0.01
    let g:neovide_cursor_trail_length=0.0
    let g:neovide_cursor_vfx_mode = "railgun"
    let g:neovide_cursor_vfx_particle_density=5.0
    let g:neovide_cursor_vfx_particle_lifetime=0.2
    let g:neovide_cursor_vfx_particle_curl=2.0

    " Default working directory to home
    autocmd VimEnter * execute "cd " . expand("$HOME")

    set mouse=a
    set guifont=JetBrains\ Mono:h12
    " :#h-slight
    " set guifont=SF\ Mono:h14:#h-slight
endif
