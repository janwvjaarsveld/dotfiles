return {
  "folke/which-key.nvim",
  optional = true,
  opts = {
    defaults = {
      ["<leader>t"] = { name = "+test" },
      ["<leader>n"] = { name = "+node package info" },
    },
  },
}
