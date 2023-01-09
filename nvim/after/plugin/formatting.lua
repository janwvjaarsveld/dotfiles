local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    formatting.stylua,
    formatting.fixjson,
    formatting.shfmt.with({
      filetypes = { "sh", "zsh" },
    }),
    code_actions.eslint_d,
    formatting.prettier,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>ff", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>ff", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

-- Reuse the Mason registered formatters and LSP server in null-ls,
-- easiest way is the use of jay-babu/mason-null-ls.nvim package.
-- see documentation of null-null-ls for more configuration options!
local mason_nullls_ok, mason_nullls = pcall(require, "mason-null-ls")
if not mason_nullls_ok then
  return
end
mason_nullls.setup({
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
})
