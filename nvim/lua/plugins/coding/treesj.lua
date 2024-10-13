return {
  "Wansmer/treesj",
  keys = { "<space>m", "<space>j", "<space>s" },
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require("treesj").setup({--[[ your config ]]
    })
  end,
}
-- {
--   "Wansmer/treesj",
--   keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
--   opts = { use_default_keymaps = false, max_join_length = 150 },
-- },
