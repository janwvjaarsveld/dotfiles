return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      go = { "gopls", "goimports", "gofumpt", lsp_format = "fallback" },
      json = { "prettierd" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      -- javascriptreact = { "dprint" },
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      typescript = { "prettierd", "prettier", lsp_format = "fallback", timeout_ms = 2500 },
      -- typescriptreact = { "dprint" },
      xml = { "xmlformatter" },
      -- yml = { "prettierd", "prettier", lsp_format = "fallback" },
      yaml = { "prettierd", "prettier", lsp_format = "fallback" },
    },
    formatters = {
      -- dprint = {
      --   condition = function(_, ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
      prettier = {
        command = "prettier",
        root_patterns = {
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yaml",
          ".prettierrc.yml",
          ".prettierrc.js",
          ".prettierrc.cjs",
          "prettier.config.js",
          "prettier.config.cjs",
        },
      },
      prettierd = {
        command = "prettierd",
        args = { "--stdin-filepath", "%filepath" },
        root_patterns = {
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yaml",
          ".prettierrc.yml",
          ".prettierrc.js",
          ".prettierrc.cjs",
          "prettier.config.js",
          "prettier.config.cjs",
        },
      },
    },
    config = function(_, opts)
      local conform = require("conform")

      -- Setup "conform.nvim" to work
      conform.setup(opts)

      -- Customise the default "prettier" command to format Markdown files as well
      conform.formatters.prettier = {
        prepend_args = { "--prose-wrap", "always" },
      }
    end,
  },
}
