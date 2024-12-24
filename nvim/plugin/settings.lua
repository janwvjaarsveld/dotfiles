vim.opt.shiftwidth = 4
-- vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"

-- search settings
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- True color support
vim.opt.termguicolors = true

-- Don't let 'o' add a comment
vim.opt.formatoptions:remove("o")

vim.opt.foldmethod = "manual"
