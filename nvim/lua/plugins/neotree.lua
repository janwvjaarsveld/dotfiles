return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "current",
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
  },
}
