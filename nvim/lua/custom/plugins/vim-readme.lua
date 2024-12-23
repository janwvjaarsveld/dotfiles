return {
  dir = "~/dev/plugins/vim-readme.nvim",
  config = function()
    require("vim-readme").setup({
      key_bindings = {
        get_package_info = "<leader>xr",
      },
    })
  end,
}
