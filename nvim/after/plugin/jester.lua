require("jester").setup({
  dap = {
    console = "externalTerminal",
  },
  prepend = {},
  -- cmd = "yarn test -t '$result'", -- run command
})

vim.keymap.set(
  "n",
  "<leader>jr",
  "<cmd>lua require('jester').run()<CR>",
  { noremap = true, silent = true, desc = "[R]un nearest test(s) under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>jf",
  "<cmd>lua require('jester').run_file()<CR>",
  { noremap = true, silent = true, desc = "Run all tests in current [F]ile " }
)
vim.keymap.set(
  "n",
  "<leader>jl",
  "<cmd>lua require('jester').run_last()<CR>",
  { noremap = true, silent = true, desc = "Run [L]ast test" }
)
vim.keymap.set(
  "n",
  "<leader>jd",
  "<cmd>lua require('jester').debug()<CR>",
  { noremap = true, silent = true, desc = "[D]ebug nearest test(s) under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>jdf",
  "<cmd>lua require('jester').debug_file()<CR>",
  { noremap = true, silent = true, desc = "[D]ebug [F]ile run all tests in current file" }
)
vim.keymap.set(
  "n",
  "<leader>jdl",
  "<cmd>lua require('jester').debug_last()<CR>",
  { noremap = true, silent = true, desc = "[D]ebug [L]ast run last test" }
)
