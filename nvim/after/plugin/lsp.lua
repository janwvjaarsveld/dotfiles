local lsp = require("lsp-zero")
local lspkind = require("lspkind")

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "sumneko_lua",
  "rust_analyzer",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end, {
    "i",
    "s",
    "c",
  }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end, {
    "i",
    "s",
    "c",
  }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text", -- show only symbol annotations
      maxwidth = 75, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    }),
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  sign_icons = {
    error = "✘",
    warn = "▲",
    hint = "⚑",
    info = "",
  },
})

vim.diagnostic.config({
  virtual_text = true,
})

vim.keymap.set("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>")
vim.keymap.set("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>")

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

lsp.configure("tsserver", {
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})

lsp.configure("sumneko_lua", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

lsp.on_attach(function(client, bufnr)
  print("LSP attached to " .. client.name)
  local opts = { buffer = bufnr, remap = false }

  if client.name == "eslint" then
    vim.cmd.LspStop("eslint")
    return
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "<leader>gi", vim.lsp.buf.incoming_calls, opts)
  vim.keymap.set("n", "<leader>go", vim.lsp.buf.outgoing_calls, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()
