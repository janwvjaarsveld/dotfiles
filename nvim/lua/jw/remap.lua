local nnoremap = require("jw.keymap").nnoremap
local inoremap = require("jw.keymap").inoremap

-- nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- Type jj to exit insert mode quickly
inoremap("jj", "<ESC>")

-- Refresh files in buffer
nnoremap("<leader>rr", ":bufdo e<CR>")

-- Close file in buffer
nnoremap("<leader>qq", ":bd<CR>")
