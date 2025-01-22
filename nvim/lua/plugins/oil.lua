return {
  {
    "stevearc/oil.nvim",
    -- ---@module 'oil'
    -- ---@type oil.SetupOpts
    -- opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require("oil").setup({
        keymaps = {
          ["q"] = { "actions.close", mode = "n" },
          ["<Bs>"] = { "actions.parent", mode = "n" },
          ["-"] = false,
        },
      })

      vim.keymap.set("n", "-", require("oil").toggle_float)
    end,
  },
}
