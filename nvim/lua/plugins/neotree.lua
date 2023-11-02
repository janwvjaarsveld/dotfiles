return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    buffers = {
      follow_current_file = { enabled = true },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          "node_modules",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
    window = {
      -- position = "current",
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          --auto close
          require("neo-tree.sources.manager").close_all()
        end,
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, reveal = true })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<leader>vsc",
      function()
        vim.api.nvim_command('TermExec cmd="code ."')
      end,
      desc = "Open VSCode",
    },
  },
}
