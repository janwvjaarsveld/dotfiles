vim.keymap.set("n", "<C-t>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>ut", vim.cmd.NvimTreeRefresh)
vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
--
local lib = require("nvim-tree.lib")

local git_stage = function()
  local node = lib.get_node_at_cursor()
  local gs = node.git_status

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

    -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  lib.refresh_tree()
end

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    side = "right",
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "<tab>", action = "git_stage", action_cb = git_stage },
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
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})
