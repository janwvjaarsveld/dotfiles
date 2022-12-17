vim.opt.guicursor = ""
vim.opt.termguicolors = true

vim.opt.smartindent = true

vim.g.mapleader = " "

vim.opt.filetype = "on"

-- Set swap files directory
vim.opt.swapfile = false
vim.opt.directory = os.getenv("HOME") .. "/.vim/swap//"

-- Allow copy and paste from VIM
vim.opt.mouse = "r"

-- Use new regular expression engine
vim.opt.re = 0

-- Add numbers to each line on the left-hand side.
vim.opt.nu = true
vim.opt.relativenumber = true

-- Highlight cursor line underneath the cursor horizontally.
vim.opt.cursorline = true

-- Set shift width to 2 spaces.
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Set tab width to 2 columns.
vim.opt.tabstop = 2

-- allow backspace immediately after insert
vim.opt.bs = "2"

-- Use space characters instead of tabs.
vim.opt.expandtab = true

-- Do not wrap lines. Allow long lines to extend as far as the line goes.
vim.opt.wrap = false

-- While searching though a file incrementally highlight matching characters as you type.
vim.opt.incsearch = true

-- Ignore capital letters during search.
vim.opt.ignorecase = true

-- Override the ignorecase option if searching for capital letters.
-- This will allow you to search specifically for capital letters.
vim.opt.smartcase = true

-- Show partial command you type in the last line of the screen.
vim.opt.showcmd = true

-- Show the mode you are on the last line.
vim.opt.showmode = true

-- Show matching words during a search.
vim.opt.showmatch = true

-- Use highlighting when doing a search.
vim.opt.hlsearch = false

-- Set the commands to save in history default number is 20.
vim.opt.history = 1000

-- save undo in a file
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn = "80"
