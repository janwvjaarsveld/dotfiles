local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = "> ",
    color_devicons = true,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<CR>"]  = actions.select_default,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
})

require("telescope").load_extension("git_worktree")

function reload_modules()
  -- Because TJ gave it to me.  Makes me happpy.  Put it next to his other
  -- awesome things.
  local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(dir, "./lua/", "")
    require("plenary.reload").reload_module(dir)
  end
end

function search_dotfiles()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

function git_branches(opts)
  opts = opts or {}
  opts.attach_mappings = function(_, map)
    map("i", "<c-d>", actions.git_delete_branch)
    map("n", "<c-d>", actions.git_delete_branch)
    return true
  end,
      require("telescope.builtin").git_branches(opts)
end

local dropdownTheme = require('telescope.themes').get_dropdown

vim.keymap.set("n", "<C-p>", ":Telescope")
vim.keymap.set("n", "<leader>ps", function()
  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
end)
vim.keymap.set("n", "<C-p>", function()
  require('telescope.builtin').git_files()
end)
vim.keymap.set("n", "<Leader>pf", function()
  require('telescope.builtin').find_files()
end)

vim.keymap.set("n", "<leader>lg", function()
  require('telescope.builtin').live_grep()
end)

vim.keymap.set("n", "<leader>pw", function()
  require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)
vim.keymap.set("n", "<leader>bb", function()
  require('telescope.builtin').buffers()
end)
vim.keymap.set("n", "<leader>vh", function()
  require('telescope.builtin').help_tags()
end)

vim.keymap.set("n", "<leader>vrc", function()
  search_dotfiles()
end)
vim.keymap.set("n", "<leader>gb", function()
  git_branches(dropdownTheme())
end)
vim.keymap.set("n", "<leader>gw", function()
  require('telescope').extensions.git_worktree.git_worktrees(dropdownTheme())
end)
vim.keymap.set("n", "<leader>gcw", function()
  require('telescope').extensions.git_worktree.create_git_worktree(dropdownTheme())
end)
vim.keymap.set("n", "<leader>gs", function()
  require('telescope.builtin').git_status(dropdownTheme())
end)
