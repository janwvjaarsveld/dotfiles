--exit insert mode with jk
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- exit vim
vim.keymap.set("n", "<leader>q!", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })

-- close current buffer
vim.keymap.set("n", "<leader>qq", ":bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })

-- source current file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
-- -- source highlighted text
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy selected text to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" })
vim.keymap.set("x", "<leader>p", [["_dP]])

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
vim.keymap.set("n", "<Down>", "5jzz", { noremap = true, silent = true, desc = "Jump 5 lines down" })
vim.keymap.set("n", "<Up>", "5kzz", { noremap = true, silent = true, desc = "Jump 5 lines up" })
