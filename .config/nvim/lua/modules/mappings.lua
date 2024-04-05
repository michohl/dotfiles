local km = vim.keymap
local g = vim.g
local a = vim.api

-- Leader
g.mapleader  = " "


-- Delete current buffer and automatically switch to next buffer instead of closing the window
km.set('n', '<Leader>d', ':bp|bd#<CR>')

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


-- Resize split panes
km.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
km.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
km.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
km.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

-- Navigate panes easier
km.set("n", "<C-k>", "<C-w><up>")
km.set("n", "<C-j>", "<C-w><down>")
km.set("n", "<C-l>", "<C-w><right>")
km.set("n", "<C-h>", "<C-w><left>")

-- Debugger (:help dap)
--    UI elements
km.set('n', '<Leader>du', function() require('dapui').toggle() end)          -- Turn on the dap-ui panels (all dap information you need at once)
km.set('n', '<Leader>lb', function() require('dap').list_breakpoints() end)  --
km.set('n', '<Leader>db', function() require('dap').clear_breakpoints() end) -- Remove all breakpoints
km.set('n', '<Leader>dr', function() require('dap').repl.open() end)         -- This is the debug console
km.set({'n', 'v'}, '<Leader>dh', function() -- This shortcut will open information about the variable under the cursor in a hover window
  require('dap.ui.widgets').hover()
end)
km.set({'n', 'v'}, '<Leader>dp', function() -- This will open information about the variable in a new split buffer
  require('dap.ui.widgets').preview()
end)
km.set('n', '<Leader>df', function()        -- This opens a hover window that shows all files involved at current point in execution and allows for jumping
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
km.set('n', '<Leader>ds', function()        -- Opens a hover window where you can inspect variables interactively
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
--    Flow Control
                                                                                    -- Keybinding for starting debug is in plugin/nvim-dap.lua
km.set('n', '<Leader>r', function() require('dap').restart() end)           -- Restart current debugging session
km.set('n', '<Leader>s', function() require('dap').step_over() end)         -- Step line by line
km.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end) -- Turn on or off breakpoint for the line your cursor is on
km.set('n', '<Leader>si', function() require('dap').step_into() end)        -- Attempt to step into the next function otherwise step over
km.set('n', '<Leader>so', function() require('dap').step_out() end)         -- Skip the next function and attempt to not enter it
km.set('n', '<Leader>dt', function() require('dap').terminate() end)        -- Kill the debug process and end current session
km.set('n', '<Leader>dc', function() require('dap').run_to_cursor() end)    -- Continue execution until the line the vim cursor is on
--vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
--

-- Allow for yanking to the system clipboard
a.nvim_set_option("clipboard","unnamed")
--km.Set('n', '<leader>y', '"+y')
--km.Set('n', '<leader>Y', '"+yg_')
--km.Set('n', '<leader>y', '"+y')
--km.Set('n', '<leader>yy', '"+yy')

-- Allow for pasting from the system clipboard
--km.Set('n', '<leader>p', '"+p')
--km.Set('n', '<leader>P', '"+P')
--km.Set('n', '<leader>p', '"+p')
--km.Set('n', '<leader>P', '"+P')
