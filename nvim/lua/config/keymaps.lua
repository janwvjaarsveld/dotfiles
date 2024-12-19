-- local util = require("util")
--
-- util.cowboy()
-- util.wezterm()
--
local map = Util.safe_keymap_set

-- change word with <c-c>
map({ "n", "x" }, "<C-c>", "<cmd>normal! ciw<cr>a")

-- exit insert mode with jk
map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- exit vim
map("n", "<leader>q!", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })

-- close current buffer
map("n", "<leader>qq", ":bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })

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

map(
  "v",
  "<leader>r",
  [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]],
  { desc = "Search and replace selected text" }
)

-- Move selected line / block of text in visual mode
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Paste from clipboard
map("n", '<leader>"', [["+p]], { desc = "Paste from clipboard" })

-- Jump multiple lines up/down using arrow keys
map("n", "<Down>", "5jzz", { noremap = true, silent = true, desc = "Jump 5 lines down" })
map("n", "<Up>", "5kzz", { noremap = true, silent = true, desc = "Jump 5 lines up" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })


-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

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

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev 
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit( { cwd = Util.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
  map("n", "<leader>gl", function() Snacks.lazygit.log({ cwd = Util.root.git() }) end, { desc = "Lazygit Log" })
  map("n", "<leader>gL", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
end

