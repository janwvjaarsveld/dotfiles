return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "ivy",
          },
        },
        extensions = {
          fzf = {},
        },
      })

      require("telescope").load_extension("fzf")

      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Find in help files" })
      vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files, { desc = "Find in files" })
      vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, { desc = "Find in files" })
      vim.keymap.set("n", "<leader>en", function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end, { desc = "Find in config files" })
      vim.keymap.set("n", "<leader>fep", function()
        require("telescope.builtin").find_files({
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
        })
      end, { desc = "Find in plugin files" })

      require("config.telescope.multigrep").setup()
    end,
  },
}
