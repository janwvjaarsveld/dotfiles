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

  use("williamboman/mason.nvim")
  use({
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓"
          }
        }
      })
      require("mason-lspconfig").setup_handlers({
        ["pylsp"] = function()
          require("lspconfig").pylsp.setup({
            on_attach = function(client, bufnr)
              require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
              require("navigator.dochighlight").documentHighlight(bufnr)
              require("navigator.codeAction").code_action_prompt(bufnr)
            end,
          })
        end,
      })
      require("mason-lspconfig").setup({
        ensure_installed = { "sumneko_lua", "rust_analyzer", "dockerls", "cssls", "eslint", "gopls", "graphql", "html",
          "jsonls", "tsserver", "pyright", "terraformls", "yamlls" }
      })
    end,
  })

  use({
    'ray-x/navigator.lua',
    requires = {
      { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
      { 'ray-x/lsp_signature.nvim' },
    },
  })

  use("simrat39/rust-tools.nvim")

  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')
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
