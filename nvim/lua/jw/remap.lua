local nnoremap = require("jw.keymap").nnoremap
local inoremap = require("jw.keymap").inoremap
local vnoremap = require("jw.keymap").vnoremap

-- nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- Type jj to exit insert mode quickly
inoremap("jj", "<ESC>")

-- Refresh files in buffer
nnoremap("<leader>rr", ":bufdo e<CR>")

-- Close file in buffer
nnoremap("<leader>qq", ":bd<CR>")

-- Copy to clipboard
vnoremap("<leader>C", ":w !pbcopy<CR><CR>")
nnoremap("<leader>C", ":.w !pbcopy<CR><CR>")
