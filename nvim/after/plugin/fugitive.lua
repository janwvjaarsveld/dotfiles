vim.keymap.set("n", "<leader>fs", vim.cmd.Git)

local JW_Fugitive = vim.api.nvim_create_augroup("JW_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
  group = JW_Fugitive,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>p", function()
      vim.cmd.Git("push")
    end, opts)
    -- force push
    vim.keymap.set("n", "<leader>p!", function()
      vim.cmd.Git("push --force-with-lease")
    end, opts)

    -- rebase always
    vim.keymap.set("n", "<leader>P", function()
      vim.cmd.Git("pull --rebase")
    end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set("n", "<leader>t", function()
      vim.cmd.Git("push -u origin ")
    end, opts)

    -- Git commit mappings
    -- Git commit with message
    vim.keymap.set("n", "<leader>c", ":Git commit -m ", opts)
    -- Git commit ammend without editing message
    vim.keymap.set("n", "<leader>ca!", function()
      vim.cmd.Git("commit --amend --no-edit")
    end, opts)
    -- Git commit ammend with editing message
    vim.keymap.set("n", "<leader>ca", function()
      vim.cmd.Git("commit --amend")
    end, opts)
  end,
})
