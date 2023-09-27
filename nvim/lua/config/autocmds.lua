-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.cmd("setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
  end,
  group = vim.api.nvim_create_augroup("auto_comment", { clear = true }),
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.cmd("setlocal commentstring=#%s")
  end,
  group = vim.api.nvim_create_augroup("auto_comment", { clear = true }),
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.cmd("setlocal commentstring=//%s")
  end,
  group = vim.api.nvim_create_augroup("auto_comment", { clear = true }),
})
