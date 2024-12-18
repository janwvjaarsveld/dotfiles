return {

  "codethread/qmk.nvim",
  dependencies = {
    "joelspadin/tree-sitter-devicetree",
  },
  config = function()
    local qmk = require("qmk")
    local qmk_group = vim.api.nvim_create_augroup("QMKFormatConfig", {})

    vim.api.nvim_create_autocmd("BufEnter", {
      desc = "Format zmk corne keyboard",
      group = qmk_group,
      pattern = "*.keymap",
      callback = function()
        qmk.setup({
          name = "layout",
          auto_format_pattern = "*.keymap",
          variant = "zmk",
          layout = {
            "x x x x x x _ _ _ x x x x x x",
            "x x x x x x _ _ _ x x x x x x",
            "x x x x x x _ _ _ x x x x x x",
            "_ _ _ _ x x x _ x x x _ _ _ _",
          },
        })
      end,
    })
  end,
}
