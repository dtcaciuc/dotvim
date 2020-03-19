set nocompatible
" set encoding=utf-8 " Necessary to show unicode glyphs

" Clone VimPlug if it doesn't exist yet
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    exec '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.nvim/site/plugged')

Plug 'ElmCast/elm-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'
Plug 'elixir-lang/vim-elixir'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'hynek/vim-python-pep8-indent'
Plug 'junegunn/vim-easy-align'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'rodjek/vim-puppet'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'cespare/vim-toml'
Plug 'akheron/cram'
Plug 'rust-lang/rust.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug '~/.brew/opt/fzf'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'

" Colors
Plug 'logico-dev/typewriter-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ikaros/smpl-vim'
Plug 'vim-scripts/PapayaWhip'

call plug#end()


" call plug#begin('~/.vim/plugged')
" Plug 'ElmCast/elm-vim'
" Plug 'elixir-lang/vim-elixir'
" Plug 'elzr/vim-json'
" " Plug 'fatih/vim-go'
" Plug 'godlygeek/tabular'
" Plug 'hynek/vim-python-pep8-indent'
" Plug 'junegunn/vim-easy-align'
" Plug 'mxw/vim-jsx'
" Plug 'pangloss/vim-javascript'
" Plug 'rodjek/vim-puppet'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-ruby/vim-ruby'
" Plug 'cespare/vim-toml'
" Plug 'akheron/cram'
" Plug 'rust-lang/rust.vim'
" 
" Plug 'w0rp/ale'

" Colors
" Plug 'NLKNguyen/papercolor-theme'
" " Plug 'lifepillar/vim-solarized8'
" " Plug 'altercation/vim-colors-solarized'
" Plug 'ikaros/smpl-vim'
" Plug 'vim-scripts/PapayaWhip'
" call plug#end()

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Dont make ding
set visualbell
" Enable line numbers
set number
" Show cursor position
set ruler
" Display the current mode and
" partially-typed commands in the status line:
set showmode
set showcmd

" Disable backup files
set nobackup
set nowritebackup

" Switch on search pattern highlighting.
set hlsearch
" Show the `best match so far'
" as search strings are typed
set incsearch

" Make command line two lines high
set ch=2

" C-indent options
set cino=t0,(0,u0,g0,l1,:0

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" For all text files set 'textwidth' to 78 characters.
" autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

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

" Netrw settings
let g:netrw_sort_sequence='[\/]$,*,\.bak$,\.info$,\.swp$,\.obj$'

" Web indent
" au BufRead *.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
" au BufRead *.js setlocal ts=2 sts=2 sw=2
" au BufRead *.coffee setlocal ts=2 sts=2 sw=2
" au BufRead *.cjsx setlocal ts=2 sts=2 sw=2
" au BufRead *.jsx setlocal ts=2 sts=2 sw=2
" au BufRead *.rb setlocal ts=2 sts=2 sw=2
" 
" au BufRead *.mak setlocal syntax=mako expandtab

au BufRead *.peg setlocal syntax=go
au BufRead *.t setlocal list listchars=eol:$,tab:>-,trail:•,extends:>,precedes:<

" Haskell

" au BufWritePre *.hs %!hindent --style fundamental

" Airline
set laststatus=2
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#ale#enabled = 1

" Ale
let g:ale_fix_on_save = 1

let g:ale_python_flake8_executable = expand('~/Library/Python/2.7/bin/flake8')
let g:ale_python_flake8_options = '*-m flake8' . ' --ignore=E501,W503'

let g:ale_javascript_eslint_executable = expand('~/.npm/bin/eslint')
let g:ale_javascript_eslint_options = '--config ' . expand('~/.eslintrc')

let g:ale_go_gofmt_executable = expand('~/.asdf/installs/golang/1.12.4/go/bin/gofmt')
let g:ale_go_gopls_executable = expand('~/.asdf/installs/golang/1.12.4/packages/bin/gopls')

let g:ale_linters = {
\   'python': ['flake8'],
\   'go': ['gopls'],
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'go': ['gofmt'],
\}
let g:LanguageClient_serverCommands = {
\   'go': ['go-langserver']
\}

" Assume .sh files are bash scripts
let g:is_bash = 1

" Elm
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

function SplitDiff()
    exe "norm gg_\<C-v>51\<Bar>Gd:vnew\<CR>p"
    silent! %s/\v\s+(\> )?$//
endfunction

" Move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

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

" Replace the word under cursor
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>

set background=light
colorscheme peachpuff
if has("gui_macvim")
    " set gfn=Fira\ Code:h14
    " set gfn=Go\ Mono\ for\ Powerline:h16
    set gfn=PragmataPro:h16
    " set gfn=Go\ Mono:h12
    " set gfn=Iosevka:h18
    " set macligatures
endif
