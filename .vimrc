" Tobys vimrc

let mapleader=" "       " set leader as space

" Global settings
set encoding=utf-8
set nocompatible
set backspace=2
set tabstop=4           " tabs are n spaces
set expandtab           " expand tabs by default (overloadable per file type)
set ruler               " underlines current line
set shiftwidth=4        " number of spaces to use for autoindenting
set softtabstop=4       " when hitting <BS>, pretend like a tab is removed, even if spaces
set cursorline
"set cursorcolumn       " show vertical cursorline
set smarttab            "insert tabs on the start of a line according to shiftwidth, not tabstop
set smartindent
set number              " Shows line numbers
set laststatus=2
set ignorecase
"set mouse=a
set clipboard=unnamed
set textwidth=100
set autoindent          " always set autoindenting on
set foldmethod=indent   " Allow folding based on ident
set foldlevel=20        " Auto unfold to level 20 (all)
set visualbell          " Disable anying bell on WSL
set colorcolumn=100      " guide ruler for line length
filetype plugin on
filetype indent on
syntax on

" Highlight searching
set incsearch
set showmatch
set hlsearch

" Disable auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Get rid of anoying files
set nobackup " do not keep backups after close
set nowritebackup " do not keep a backup while working
set noswapfile " don't keep swp files either

" Map jj to escape insert mode, its quicker
imap jj <Esc>

" Switch vim windows
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" enable spelling for markdown. ctl+ N/P auto completes
" toggle spell check on off with F5
:map <F5> :setlocal spell! spelllang=en_gb<CR>
autocmd BufRead, BufNewFile *.md, *.txt setlocal spell spelllang=en_gb
set complete+=kspell
set spellfile=$HOME/Dropbox/folders/technology/vim_spell/en.utf-8.add

" Line wrap for markdown
au BufRead,BufNewFile *.md setlocal textwidth=100
set autoindent

" Alias write and quit
nnoremap <leader>q :wq<CR>
nnoremap <leader>w :w<CR>

" Set tmux pane title, to open vim filename
" autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e


" --------------------------------- PLUGINS  ------------------------------------------------------

" Make sure Plug is installed first
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'              " nice colour theme
Plug 'scrooloose/nerdtree'          " File explorer tree
Plug 'tpope/vim-fugitive'           " Nice git integration
Plug 'vim-airline/vim-airline'      " Nice status bar
Plug 'frazrepo/vim-rainbow'         " Color matches brackets
Plug 'jiangmiao/auto-pairs'         " auto closes brackets
Plug 'airblade/vim-gitgutter'       " Show git status on the left.
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'          " Sets fzf root to gitfile

call plug#end()
" Reload .vimrc and :PlugInstall to install plugins
" --------------------------------- PLUGINS END ---------------------------------------------------


"--------------------------------- PLUGIN CONFIGURATION -------------------------------------------

" Rainbox pairs
au FileType c,cpp,objc,objcpp,js call rainbow#load()
let g:rainbow_active = 1


" NERDTree
"map <C-n> :NERDTreeToggle<CR>
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
nnoremap <Leader>pt :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>pv :NERDTreeFind<CR>


" fzf
nnoremap <C-p> :Files<Cr>           " map ctrl+p to fzf


" RipGrep
nnoremap <leader>g :Rg<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


" colours
colorscheme gruvbox
set background=dark

