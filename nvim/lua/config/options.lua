vim.g.mapleader = " "

vim.opt.backup = true
vim.opt.cmdheight = 0
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
vim.opt.mousescroll = "ver:2,hor:6"

if vim.g.neovide then
  vim.o.guifont = "Fira Code,Symbols Nerd Font Mono:h34"
  vim.g.neovide_scale_factor = 0.3
end

-- vim.g.node_host_prog = "/Users/folke/.pnpm-global/5/node_modules/neovim/bin/cli.js"
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

-- vim.opt.mouse = "a" -- enable mouse support
vim.opt.mouse = "ar" -- Allow copy and paste from VIM
vim.opt.incsearch = true -- While searching though a file incrementally highlight matching characters as you type.
vim.opt.showmatch = true -- Show matching words during a search.
vim.opt.hlsearch = false -- Use highlighting when doing a search.
vim.opt.clipboard = "" -- Do not sync with system clipboard
vim.opt.swapfile = false -- Do not create swap files
vim.opt.directory = os.getenv("HOME") .. "/.vim/swap//" -- Set swap files directory
vim.opt.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
vim.opt.foldmethod = "manual"
