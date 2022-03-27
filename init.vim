if has('win64')
  let vimfiles = expand('$HOME/AppData/Local/nvim')
else
  let vimfiles = expand("$HOME/.vim")
endif

let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if !filereadable(vimfiles.'/autoload/plug.vim')
  exec '!curl -fLo '.vimfiles.'/autoload/plug.vim --create-dirs '.plugurl
endif

call plug#begin(vimfiles.'/site/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'elixir-lang/vim-elixir'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'plan9-for-vimspace/acme-colors'
Plug 'Chiel92/vim-autoformat'
Plug 'rust-lang/rust.vim'
call plug#end()

set nowrap
set acd " autochdir

nnoremap <Leader>w <C-w>

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

" Necessary to show unicode glyphs
set encoding=utf-8
" Don't autocomplete on first tab on cmdline
set wildmode=longest:full,full
set smartindent
set number

let g:airline_symbols_ascii = 1
let g:airline#extensions#nvimlsp#enabled = 1

lua <<EOF
  lspconfig = require "lspconfig"
  lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }

  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --   vim.lsp.diagnostic.on_publish_diagnostics,
  --   {
  --     virtual_text = false,
  --     signs = true,
  --     update_in_insert = false,
  --     underline = true,
  --     -- display_diagnostic_autocmds = { "InsertLeave" },
  --   }
  -- )
EOF

autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()

function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/nvim.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction
