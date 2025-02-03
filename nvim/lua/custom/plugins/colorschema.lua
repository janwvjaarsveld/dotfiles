return {
  -- {
  -- "catppuccin/nvim",
  -- name = "catppuccin",
  -- priority = 1000,
  -- config = function()
  --   vim.cmd("colorscheme catppuccin")
  -- end},
  {
    "maxmx03/dracula.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require("dracula").setup({})
      vim.cmd.colorscheme("dracula")
    end,
  },
  -- {
  --   "dracula/vim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd.colorscheme("dracula")
  --   end,
  -- },
  -- {
  --   "oxfist/night-owl.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     require("night-owl").setup()
  --     vim.cmd.colorscheme("night-owl")
  --   end,
  -- },
}
