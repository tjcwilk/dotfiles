
" Set tabs to 4 spaces
set number
set cursorline
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 
set smarttab

" Highlight searching
set incsearch
set showmatch
set hlsearch

" Highlight line width
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Disable the arrow keys to force good vim practice
"no <down> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"no <up> <Nop>
"ino <down> <Nop>
"ino <left> <Nop>
"ino <right> <Nop>
"ino <up> <Nop>

" Load pathogen module
execute pathogen#infect()
syntax on
filetype plugin indent on

" Enable Powerline. Make sure to install powerline first,
" Use the install.sh script
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" Set molokai colour scheme
let g:molokai_original = 1
