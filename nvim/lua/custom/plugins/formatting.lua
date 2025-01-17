return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      go = { "gopls", "goimports", "gofumpt", lsp_format = "fallback" },
      lua = { "stylua" },
      python = { "ruff", "black", stop_after_first = true },
      markdown = { "prettier", "markdownlint", stop_after_first = true },
      javascript = { "prettier", lsp_format = "fallback", stop_after_first = true },
      typescript = { "prettier", lsp_format = "fallback", stop_after_first = true },
      _ = { "prettierd" },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 1500 },

    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      -- dprint = {
      --   condition = function(_, ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
