local nnoremap = require("jw.keymap").nnoremap

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    side = "right",
    adaptive_size = false,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
    number = true,
    relativenumber = true,
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 100,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "✗",
          staged = "✚",
          unmerged = "═",
          renamed = "➜",
          untracked = "★",
          deleted = "␡",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    dotfiles = true,
  },
})

nnoremap("<C-t>", ":NvimTreeToggle<CR>")
nnoremap("<leader>ut", ":NvimTreeRefresh<CR>")
nnoremap("<leader>t", ":NvimTreeFindFile<CR>")
