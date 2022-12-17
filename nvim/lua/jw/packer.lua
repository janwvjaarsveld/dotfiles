return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- use('tomasr/molokai')

  use({ 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  })

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  })

  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')

  use({ 'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })

  use({ 'rose-pine/neovim',
    as = 'rose-pine'
  })

  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')

  use({ 'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }, tag = 'nightly' -- optional, updated every week. (see issue #1193)
  })
  use('ThePrimeagen/git-worktree.nvim')

  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use({ 'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  })

  use("github/copilot.vim")
end)