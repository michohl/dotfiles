local o = vim.opt
local g = vim.g


-- Visual stuff
o.number     = true
o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
o.cmdheight  = 2
g.markdown_fenced_languages = { 'javascript', 'json', 'python', 'go', 'bash' }


-- Linting
o.signcolumn = "yes"

-- Searching
o.incsearch  = true
o.hlsearch   = true
o.showmatch  = true

-- Tabbing
o.expandtab   = true
o.smarttab    = true
o.shiftwidth  = 4
o.tabstop     = 4
o.softtabstop = 4
o.smartindent = true

-- Disable noises
g.noerrorbells = true

-- Allow undoing changes after re-opening a closed file
g.noswapfile = true
g.nobackup   = true
o.undodir    = vim.fn.stdpath('config') .. '/.undodir'
o.undofile   = true

-- If you don't specify a capital in your search then it's case insensitive
o.smartcase = true

-- Change how low cursor must be to begin screen scrolling off
o.scrolloff = 8

-- Allow using the mouse for certain things
o.mouse = 'a'
