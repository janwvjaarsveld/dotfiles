return {
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },
  opts = {
    close_if_last_window = true,
    buffers = {
      follow_current_file = { enabled = true },
    },
    window = {
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      },
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
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignore = false,
        hide_by_pattern = { ".git", "node_modules" },
        never_show = { ".DS_Store" },
      },
    },
  },
}
