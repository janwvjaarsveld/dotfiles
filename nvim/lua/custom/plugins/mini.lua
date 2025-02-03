-- lua/custom/plugins/mini.lua
return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    config = function()
      -- statusline
      local status_line_content = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end

      require("mini.statusline").setup({ use_icons = true, content = { active = status_line_content } })

      -- tabline
      require("mini.tabline").setup({ use_icons = true })

      require("mini.ai").setup()
      -- require("mini.animate").setup()
      require("mini.bracketed").setup()
      require("mini.jump2d").setup()
      require("mini.surround").setup({})

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
