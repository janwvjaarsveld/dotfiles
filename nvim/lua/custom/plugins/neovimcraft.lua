return {
  dir = "~/dev/plugins/neovimcraft.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "ellisonleao/glow.nvim",
      config = function()
        require("glow").setup({ width = 300, height = 300 })
      end,
      cmd = "Glow",
    },

    -- {
    --   "MeanderingProgrammer/render-markdown.nvim",
    --   ft = { "markdown", "quarto" },
    --   config = function()
    --     require("render-markdown").setup({})
    --   end,
    -- },
    -- {
    --   "OXY2DEV/markview.nvim",
    --   lazy = false, -- Recommended
    --   -- ft = "markdown" -- If you decide to lazy-load anyway
    --
    --   dependencies = {
    --     "nvim-treesitter/nvim-treesitter",
    --     "nvim-tree/nvim-web-devicons",
    --   },
    -- },
  },
  -- config = function()
  --   require("neocraft").setup()
  -- end,
}
