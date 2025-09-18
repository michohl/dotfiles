require("plugins")

vim.cmd [[
  runtime! lua/modules/options.lua
  runtime! lua/modules/mappings.lua
  runtime! lua/modules/util.lua
]]

-- Find and load envFiles required for VS Code launch.json debugging
require("loadEnvFiles")


-- Add hot reloading for Kitty config changes
require("kittyHotReloading")

-- Enable LSP
vim.lsp.enable({
  'eslint',
  'luals',
  'gopls',
  'pyright',
  'tsserver'
})

-- Turn on diagnostic lines
vim.diagnostic.config({
  -- virtual_lines = true,
   virtual_text = true,
})
