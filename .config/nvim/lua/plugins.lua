local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim'               -- Have packer manage itself
  use "nvim-lua/popup.nvim"                  -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"                -- Useful lua functions used by lots of plugins


  use { "ellisonleao/gruvbox.nvim" }         -- Colorscheme

  use({ "cappyzawa/trim.nvim",               -- Auto trim whitespace
  config = function()
    require("trim").setup({})
  end
  })

  -- Searching
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'rust',
        'typescript',
        'cmake',
        'vim',
        'vimdoc',
        'markdown',
        'markdown_inline',
      },
      highlight = { enable = true, }
    }
    end
  }

  -- Show inline comments of git blame
  use { 'f-person/git-blame.nvim' }

  -- Show all buffers as a status item
  use { 'bling/vim-bufferline' }

  -- Preview markdown files
  --use { 'ellisonleao/glow.nvim' }

  -- File tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = "nvim-tree/nvim-web-devicons"
  }

  -- Debugger
  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go'
  use {
    'rcarriga/nvim-dap-ui',
    requires = "nvim-neotest/nvim-nio"
  }

  -- Golang QoL
  use {
    'crispgm/nvim-go',
    requires = {
      {'rcarriga/nvim-notify'}, -- Optional
      {'nvim-lua/plenary.nvim'},
    }
  }

  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }

  -- use {'github/copilot.vim', branch = 'release' }

  use({
  "epwalsh/obsidian.nvim",
  tag = "*",  -- recommended, use latest release instead of latest commit
  requires = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },

  use {
  "pmizio/typescript-tools.nvim",
  requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("typescript-tools").setup {}
  end,
  },

  -- Preview Swagger (OpenAPI) files
  use {
    "vinnymeller/swagger-preview.nvim",
    run = "npm i",
  }
})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
