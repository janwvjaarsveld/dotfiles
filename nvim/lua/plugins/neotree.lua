return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          --auto close
          require("neo-tree.sources.manager").close_all()
        end,
      },
    },
  },
}
