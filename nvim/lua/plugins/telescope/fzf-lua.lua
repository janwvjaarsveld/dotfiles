vim.env.FZF_DEFAULT_OPTS = ""
return {
  "ibhagwan/fzf-lua",
  optional = true,
  keys = {
    {
      "<leader>fp",
      LazyVim.pick("files", { cwd = require("lazy.core.config").options.root }),
      desc = "Find Plugin File",
    },
    {
      "<leader>sp",
      function()
        local dirs = { "~/dotfiles/nvim/lua/plugins" }
        require("fzf-lua").live_grep({
          filespec = "-- " .. table.concat(vim.tbl_values(dirs), " "),
          search = "/",
          formatter = "path.filename_first",
        })
      end,
      desc = "Find Lazy Plugin Spec",
    },
  },
}
