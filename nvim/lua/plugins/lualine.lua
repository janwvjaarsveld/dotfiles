return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1 },
      },
    },
  },
}
