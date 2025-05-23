local map = vim.keymap.set

--exit insert mode with jk
map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- exit vim
map("n", "<leader>q!", ":on | q<CR>", { noremap = true, silent = true, desc = "Quit" })
map("n", "<leader>qq", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })

map(
  "n",
  "<leader>R",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)

map("v", "<leader>R", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]], { desc = "Search and replace selected text" })

-- Move selected line / block of text in visual mode
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- quickfix
map("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- map("n", "<c-\\>", function()
--   Snacks.terminal()
-- end, { desc = "Terminal (Root Dir)" })

-- Terminal Mappings
map("t", "<C-e>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
