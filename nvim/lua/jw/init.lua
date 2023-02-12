require("jw.set")
require("jw.remap")
require("jw.custom")
require("jw.packer")
require("jw.lsp")
require("jw.bfs")

local augroup = vim.api.nvim_create_augroup
local jwGroup = augroup("jw", {})
local yank_group = augroup("HighlightYank", {})
local bufcheck = augroup("bufcheck", { clear = true })

local autocmd = vim.api.nvim_create_autocmd

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = jwGroup,
  pattern = "*",
  command = [[%s/\\s\\+$//e]],
})

autocmd("BufReadPost", {
  group = bufcheck,
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos(".", vim.fn.getpos("'\""))
      vim.cmd("silent! foldopen")
    end
  end,
})
