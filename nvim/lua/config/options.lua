-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.mouse = "r" -- Allow copy and paste from VIM
vim.opt.incsearch = true -- While searching though a file incrementally highlight matching characters as you type.
vim.opt.showmatch = true -- Show matching words during a search.
vim.opt.hlsearch = false -- Use highlighting when doing a search.
vim.opt.clipboard = "" -- Do not sync with system clipboard
vim.opt.swapfile = false -- Do not create swap files
vim.opt.directory = os.getenv("HOME") .. "/.vim/swap//" -- Set swap files directory
vim.opt.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
