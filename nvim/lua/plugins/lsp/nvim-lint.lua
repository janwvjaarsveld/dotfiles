return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      lua = { "selene", "luacheck" },
    },
    linters = {
      selene = {
        condition = function(ctx)
          local root = LazyVim.root.get({ normalize = true })
          if root ~= vim.uv.cwd() then
            return false
          end
          return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
        end,
      },
      luacheck = {
        condition = function(ctx)
          local root = LazyVim.root.get({ normalize = true })
          if root ~= vim.uv.cwd() then
            return false
          end
          return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
        end,
      },
    },
  },
}
