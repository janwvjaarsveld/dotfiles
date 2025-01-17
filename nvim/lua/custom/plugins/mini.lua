-- lua/custom/plugins/mini.lua
return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    config = function()
      -- statusline
      require("mini.statusline").setup({ use_icons = true })

      -- tabline
      require("mini.tabline").setup({ use_icons = true })

      require("mini.ai").setup()
      -- require("mini.animate").setup()
      require("mini.bracketed").setup()
      require("mini.jump2d").setup()
      require("mini.surround").setup()

      vim.keymap.set("n", "f", "<cmd>lua MiniJump2d.start()<CR>", { noremap = true, silent = true })

      -- notify
      -- local notify = require("mini.notify")
      -- notify.setup()
      -- vim.notify = notify.make_notify({
      --   ERROR = { duration = 5000 },
      --   WARN = { duration = 3000 },
      --   INFO = { duration = 2000 },
      -- })
    end,
  },
}
