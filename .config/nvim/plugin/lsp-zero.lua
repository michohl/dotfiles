local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- Valid server list is found here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#configurations
lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
  'ansiblels',
  -- 'awk_ls',
  'bashls',
  'clangd',
  -- 'neocmake',
  'dockerls',
  'eslint',
  'gopls',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'terraformls',
  'tsserver',
  'yamlls'
})

lsp.configure("yamlls", {
  settings = {
    yaml = {
      keyOrdering = false,
      customTags = { '!reference' },
    }
  }
})

lsp.setup()
