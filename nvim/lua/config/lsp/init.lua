local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.formatting_seq_sync()
      end
    })
  end
end

local keymaps = require("config.lsp.keymaps")

require("lsp_signature").setup {
  bind = true,
  handler_opts = {
    border = "single",
  },
  debug = true,
  max_width = 80,
  toggle_key = "<C-h>",
  floating_window = true,
  hint_enable = false,
}

require('navigator').setup({
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, can be one of 'none', 'single', 'double',
  -- 'shadow', or a list of chars which defines the border
  on_attach = on_attach,

  ts_fold = false, -- modified version of treesitter folding
  default_mapping = false, -- set to false if you will remap every key or if you using old version of nvim-
  -- Configure key mappings
  keymaps = keymaps,
  -- this value prevent slow in large projects, e.g. found 100000 reference in a project
  transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it

  lsp_signature_help = nil, -- if you would like to hook ray-x/lsp_signature plugin in navigator
  -- setup here. if it is nil, navigator will not init signature help
  icons = {
    -- Code action
    code_action_icon = "🏏", -- note: need terminal support, for those not support unicode, might crash
    -- Diagnostics
    diagnostic_head = '🐛',
    diagnostic_head_severity_1 = "🈲",
    -- refer to lua/navigator.lua for more icons setups
  },
  mason = true, -- set to true if you would like use the lsp installed by williamboman/mason
  lsp = {
    disable_lsp = { "pylsp" }, -- disable pylsp setup from navigator
    code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
    code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
    diagnostic_scrollbar_sign = { '▃', '▆', '█' }, -- experimental:  diagnostic status in scroll bar area; set to false to disable the diagnostic sign,
    --                for other style, set to {'╍', 'ﮆ'} or {'-', '='}
  }
})

require('rust-tools').setup({
  server = {
    on_attach = function(client, bufnr)
      require('navigator.lspclient.mapping').setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,

      require("navigator.dochighlight").documentHighlight(bufnr)
      require('navigator.codeAction').code_action_prompt(bufnr)
      -- otherwise, you can define your own commands to call navigator functions
    end,
  }
})
