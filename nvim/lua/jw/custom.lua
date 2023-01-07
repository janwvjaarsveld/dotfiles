-- Function to quickly open/hide terminal window inside vim
-- Terminal operation  when
-- 1. terminal is open in split window, it closes the window (terminal still
--    running)
-- 2. terminal open in buffer, it moves window into split window
-- 3. no termial instance running then it opens new terminal instance in split
--    window
local function Term()
  local terminal_buffer_number = vim.fn.bufnr("term://")
  local terminal_window_number = vim.fn.bufwinnr("term://")
  local window_count = vim.fn.winnr("$")
  local current_buffer_number = vim.fn.bufnr("%")

  if terminal_window_number > 0 and window_count > 1 then
    vim.fn.execute(terminal_window_number .. "wincmd c")
  elseif terminal_buffer_number > 0 and terminal_buffer_number ~= current_buffer_number then
    vim.fn.execute("sb " .. terminal_buffer_number)
    -- local width = vim.fn.winwidth(0) * 0.8
    -- print(width)
    -- vim.api.nvim_open_win(terminal_buffer_number, true, {
    --   relative = "win",
    --   width = width,
    --   height = 80,
    --   border = "rounded",
    --   win = 1001,
    --   row = 10,
    --   col = 10,
    --   zindex = 3,
    -- })
  elseif terminal_buffer_number == current_buffer_number then
    print(3)
    vim.fn.execute("bprevious | sb " .. terminal_buffer_number .. " | wincmd p")
  else
    vim.fn.execute("sp term://zsh")
  end
end

vim.api.nvim_create_user_command("Term", Term, {
  desc = "Open terminal window",
})

vim.keymap.set("n", "<leader>.", vim.cmd.Term, { noremap = true, silent = true })
vim.keymap.set("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
