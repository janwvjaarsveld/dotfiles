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
