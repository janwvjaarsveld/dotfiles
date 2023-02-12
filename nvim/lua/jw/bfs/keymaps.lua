M = {}
-- Set floating window keymaps
function M.setKeymaps(win, buf)
  vim.api.nvim_buf_set_option(buf, "filetype", "bfs")
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "<CR>",
    string.format([[:<C-U>lua require'jw.bfs'.selBufNum(%s, 'window', vim.v.count)<CR>]], win),
    { nowait = true, noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "q",
    ':lua require"jw.bfs".close()<CR>',
    { nowait = true, noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "d",
    string.format([[:lua require'jw.bfs'.closeBufNum(%s)<CR>]], win),
    { nowait = true, noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "l",
    string.format([[:<C-U>lua require'jw.bfs'.selBufNum(%s, 'window', vim.v.count)<CR>]], win),
    { nowait = true, noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "s",
    string.format([[:<C-U>lua require'jw.bfs'.selBufNum(%s, 'hsplit', vim.v.count)<CR>]], win),
    { nowait = true, noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "v",
    string.format([[:<C-U>lua require'jw.bfs'.selBufNum(%s, 'vsplit', vim.v.count)<CR>]], win),
    { nowait = true, noremap = true, silent = true }
  )
end

return M
