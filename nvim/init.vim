" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', {'branch': 'v3.x'}
call plug#end()

" Neo-tree configuration
lua << EOF
require("neo-tree").setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  window = {
    position = "left",
    width = 30,
    mappings = {
      ["<space>"] = "none",
      ["e"] = "open",
      ["P"] = { "focus_preview", "close_on_open" },
      ["l"] = "focus_preview",
      ["h"] = "close_node",
    }
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
  }
})
EOF

" Neo-tree keymap
nnoremap <leader>e :Neotree toggle<CR>


" Color scheme
set termguicolors
colorscheme catppuccin-frappe

" Basic settings
syntax on
set number
set relativenumber
set cursorline
set scrolloff=8
set sidescrolloff=8
set incsearch
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set wildmenu
set wildmode=longest,list,full

" Leader key
let mapleader = " "

" Save and quit shortcut
nnoremap <leader>wq :wq<CR>
