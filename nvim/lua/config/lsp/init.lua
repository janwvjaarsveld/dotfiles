local keymaps = require("config.lsp.keymaps")
local inoremap = require("jw.keymap").inoremap

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

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
        vim.lsp.buf.format()
        organize_imports()
      end
    })
  end
end

require("lsp_signature").setup {
  bind = true,
  handler_opts = {
    border = "single",
  },
  wrap = true,
  -- max_width = 80,
  max_height = 5,
  toggle_key = "<C-h>",
  floating_window = true,
  hint_enable = false,
  hint_prefix = " ",
  hint_scheme = "String",
  auto_close_after = 500,
  extra_trigger_chars = { "(", "," },
  floating_window_offset_x = 50,
  select_signature_key = "<M-n>",
}

local function escape_term_codes(str)
  return vim.api.nvim_replace_termcodes(str, true, false, true)
end

local function is_lsp_float_open(window_id)
  return window_id and window_id ~= 0 and vim.api.nvim_win_is_valid(window_id)
end

local function scroll_float(mapping)
  -- Using the global config of the lsp_signature plugin
  local window_id = _G._LSP_SIG_CFG.winnr

  if is_lsp_float_open(window_id) then
    vim.fn.win_execute(window_id, 'normal! ' .. mapping)
  end
end

local opts = { noremap = true, silent = true }
local scroll_up_mapping = escape_term_codes('<c-u>')
local scroll_down_mapping = escape_term_codes('<c-d>')
inoremap("<c-u>", function() scroll_float((scroll_up_mapping)) end, opts)
inoremap("<c-d>", function() scroll_float((scroll_down_mapping)) end, opts)


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
    tsserver = {
      -- keymaps = keymaps,
      on_attach = on_attach,
      commands = {
        OrganizeImports = {
          organize_imports,
          description = "Organize Imports"
        }
      }
    }
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
