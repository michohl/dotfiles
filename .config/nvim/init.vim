" Plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'   " File searching
Plug 'nvim-treesitter/nvim-treesitter' " Telescope dependency
Plug 'nvim-lua/plenary.nvim'           " Dependency of telescope
Plug 'BurntSushi/ripgrep'              " enable live_grep in Telescope
Plug 'sharkdp/fd'                      " fd for Telescope
Plug 'gruvbox-community/gruvbox'       " Colorscheme
Plug 'preservim/nerdtree'              " File Explorer
Plug 'f-person/git-blame.nvim'         " Toggleable git blame
Plug 'ellisonleao/glow.nvim', {'branch': 'main'} " Preview Markdown files
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP / Text Completion
Plug 'bling/vim-bufferline'            " Vim buffer statusline
call plug#end()

" <leader>
let mapleader = " "

" Misc remaps
noremap <leader>te <cmd>vsplit term://zsh<cr>

" filetypes
filetype plugin on
filetype indent on

" Visual
syntax enable
set number
colorscheme gruvbox
set background=dark
set cmdheight=2
let g:markdown_fenced_languages = [ 'javascript', 'json', 'python', 'go', 'bash' ]

" Linting
"set colorcolumn=80  " Enable if you want a red bar showing a red column @ 80
set signcolumn=yes

" Searching options
set incsearch
set hlsearch
set showmatch

" Tabbing settings
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4 softtabstop=4
set smartindent

" Disable noises made by vim
set noerrorbells

" Allows undoing changes after closing and re-opening a file
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" If you don't specify a capital the search is case insensitive
set smartcase

" Change how low cursor must be to begin screen scrolling
set scrolloff=8

" COC Settings
"autocmd VimEnter * CocStart

" NERDTree Settings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Telescope Settings
lua << EOF
require("telescope").setup {
    defaults = {
        file_ignore_patterns = {"Library"}
    },
    pickers = {
        live_grep = {
            additional_args = function(opts)
                return {"--hidden"}
            end
        },
    },
}
EOF
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep hidden=true<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

" git-blame Settings
let g:gitblame_enabled = 1
noremap <leader>gb <cmd>GitBlameToggle<cr>

" On file write automatically remove all trailing whitespace found
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup mmr
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END
