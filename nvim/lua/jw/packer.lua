return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  use('tomasr/molokai')

  use('nvim-lua/plenary.nvim')

  use({ 'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })

  use('nvim-treesitter/nvim-treesitter', {
    run = ':TSUpdate'
  })

  use('ThePrimeagen/git-worktree.nvim')

  use('romgrk/nvim-treesitter-context')

  use({ 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  })

  use({ 'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }, tag = 'nightly' -- optional, updated every week. (see issue #1193)
  })

  use("mbbill/undotree")

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  })

  -- LSP
  -- use({
  --   "neovim/nvim-lspconfig",
  --   opt = true,
  --   event = "BufReadPre",
  --   wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lsp_signature.nvim" },
  --   config = function()
  --     require("config.lsp").setup()
  --   end,
  --   requires = {
  --     "williamboman/nvim-lsp-installer",
  --     "ray-x/lsp_signature.nvim",
  --   },
  -- })

  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")
  use("ray-x/lsp_signature.nvim")


  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')
  -- use({
  --   "neovim/nvim-lspconfig",
  --   opt = true,
  --   event = "BufReadPre",
  --   wants = { "cmp-nvim-lsp", "mason", "mason-lspconfig", "lsp_signature.nvim" },
  --   config = function()
  --     require("config.lsp").setup()
  --   end,
  --   requires = {
  --     "williamboman/mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --     "ray-x/lsp_signature.nvim",
  --   },
  -- })

  use("hrsh7th/cmp-nvim-lsp")

  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.cmp").setup()
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require("config.luasnip").setup()
        end,
      },
      "rafamadriz/friendly-snippets",
    },
    disable = false,
  })
  use("nvim-lua/lsp_extensions.nvim")
end)
