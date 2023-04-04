local km = vim.keymap
local g = vim.g

-- Leader
g.mapleader  = " "


-- Open a new terminal in vim
km.set('n', '<Leader>te', ':term://zsh<cr>')


-- NerdTree mappings
km.set('n', '<Leader>n', ':NvimTreeFocus<CR>')
km.set('n', '<C-n>',     ':NvimTree<CR>')
km.set('n', '<C-t>',     ':NvimTreeToggle<CR>')
km.set('n', '<C-f>',     ':NvimTreeFindFile<CR>')

-- Telescope mappings
km.set('n', '<Leader>ff', '<cmd>Telescope find_files hidden=true<cr>')
km.set('n', '<Leader>fg', '<cmd>Telescope live_grep  hidden=true<cr>')
km.set('n', '<Leader>fb', '<cmd>Telescope buffers')

-- git-blame mappings
km.set('n', '<Leader>gb', '<cmd>GitBlameToggle<cr>')

-- Cycle through buffers
km.set('n', '<A-Right>', '<cmd>bnext<CR>')
km.set('n', '<A-Left>', '<cmd>bprevious<CR>')
