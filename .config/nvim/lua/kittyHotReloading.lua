-- All of our helper functions

local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

autocmd('BufWritePost', {
  pattern = 'kitty.conf',
  command = ":silent !kill -SIGUSR1 $(pgrep -a kitty)"
})
