local map = vim.keymap.set

--exit insert mode with jk
map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- exit vim
map("n", "<leader>q!", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })

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
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)

map("v", "<leader>r", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]], { desc = "Search and replace selected text" })

-- Move selected line / block of text in visual mode
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Paste from clipboard
map("n", '<leader>"', [["+p]], { desc = "Paste from clipboard" })

-- lines up/down and keep the cursor in the same position
map("n", "<C-j>", "jzz", { noremap = true, silent = true, desc = "Lines down" })
map("n", "<C-k>", "kzz", { noremap = true, silent = true, desc = "Lines up" })
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

-- Terminal Mappings
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  -- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
