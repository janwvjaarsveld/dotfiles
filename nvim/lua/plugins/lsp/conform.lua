return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["javascript"] = { "dprint", { "prettierd", "prettier" } },
      ["javascriptreact"] = { "dprint" },
      ["typescript"] = { "dprint", { "prettierd", "prettier" } },
      ["typescriptreact"] = { "dprint" },
    },
    formatters = {
      dprint = {
        condition = function(_, ctx)
          return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        end,
      },
    },
  },
}
