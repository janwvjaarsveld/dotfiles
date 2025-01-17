local map = vim.keymap.set

--exit insert mode with jk
map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- exit vim
map("n", "<leader>q!", ":on | q<CR>", { noremap = true, silent = true, desc = "Quit" })
map("n", "<leader>qq", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })

-- source current file
map("n", "<leader>xs", "<cmd>source %<CR>", { desc = "Source current file" })
map("n", "<leader>xe", ":.lua<CR>", { desc = "Execute the current file" })
-- -- source highlighted text
map("v", "<space>x", ":lua<CR>", { desc = "Source highlighted text" })

map("n", "<M-j>", "<cmd>cnext<CR>")
map("n", "<M-k>", "<cmd>cprev<CR>")

-- Copy to clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy selected text to clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" })
map("x", "<leader>p", [["_dP]])

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

-- Paste from clipboard
map("n", '<leader>"', [["+p]], { desc = "Paste from clipboard" })

-- lines up/down and keep the cursor in the same position
-- map("n", "<C-j>", "jzz", { noremap = true, silent = true, desc = "Lines down" })
-- map("n", "<C-k>", "kzz", { noremap = true, silent = true, desc = "Lines up" })
-- Jump multiple lines up/down using arrow keys
map("n", "<Down>", "5jzz", { noremap = true, silent = true, desc = "Jump 5 lines down" })
map("n", "<Up>", "5kzz", { noremap = true, silent = true, desc = "Jump 5 lines up" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- quickfix
map("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- There are builtin keymaps for this now, but I like that it shows
-- the float when I navigate to the error - so I override them.
-- map("n", "]d", fn(vim.diagnostic.jump, { count = 1, float = true }))
-- map("n", "[d", fn(vim.diagnostic.jump, { count = -1, float = true }))

-- These mappings control the size of splits (height/width)
map("n", "<M-,>", "<c-w>5<")
map("n", "<M-.>", "<c-w>5>")
map("n", "<M-t>", "<C-W>+")
map("n", "<M-s>", "<C-W>-")

-- floating terminal
map("n", "<leader>fT", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<leader>ft", function()
  Snacks.terminal(nil, { cwd = Util.getRoot() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-/>", function()
  Snacks.terminal(nil, { cwd = Util.getRoot() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>", function()
  Snacks.terminal(nil, { cwd = Util.getRoot() })
end, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
