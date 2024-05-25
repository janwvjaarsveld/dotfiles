return {
  "nvim-pack/nvim-spectre",
  opts = {
    open_cmd = "noswapfile vnew",
    mapping = {
      ["toggle_multi_line"] = {
        map = "tm",
        cmd = "<cmd>lua require('spectre').change_options('multi-line')<CR>",
        desc = "toggle search multi line",
      },
    },
    find_engine = {
      ["rg"] = {
        cmd = "rg",
        options = { ["multi-line"] = { value = "--multiline", desc = "multi line", icon = "[M]" } },
      },
    },
  },
}
