-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- exit insert mode with jk
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- exit vim
vim.keymap.set("n", "<leader>q!", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })

-- close current buffer
vim.keymap.set("n", "<leader>qq", ":bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy selected text to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" })

vim.keymap.set(
  "n",
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)

vim.keymap.set(
  "v",
  "<leader>r",
  [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]],
  { desc = "Search and replace selected text" }
)

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Paste from clipboard
vim.keymap.set("n", '<leader>"', [["+p]], { desc = "Paste from clipboard" })

-- Jump multiple lines up/down using arrow keys
vim.keymap.set("n", "<Down>", "5j", { noremap = true, silent = true, desc = "Jump 5 lines down" })
vim.keymap.set("n", "<Up>", "5k", { noremap = true, silent = true, desc = "Jump 5 lines up" })
