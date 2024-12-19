return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    filetypes = { ["*"] = true },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<C-l>",
        accept_word = false,
        accept_line = false,
        next = "<C-]>",
        dismiss = "<C-?>",
      },
    },
  },
}
