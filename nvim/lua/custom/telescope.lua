local data = assert(vim.fn.stdpath("data"))

local open_with_trouble = require("trouble.sources.telescope").open

require("telescope").setup({
  defaults = {
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
  },
  extensions = {
    wrap_results = true,
    fzf = {},
    -- history = {
    --   path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
    --   limit = 100,
    -- },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find in help files" })
vim.keymap.set("n", "<leader>fd", builtin.find_files, { desc = "Find in files" })
vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Find in files" })
vim.keymap.set("n", "<space>fb", builtin.buffers, { desc = "Find in buffers" })
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = "Find in current buffer" })
vim.keymap.set("n", "<leader>fc", function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
  })
end, { desc = "Find in config files" })
vim.keymap.set("n", "<leader>fp", function()
  builtin.find_files({
    cwd = vim.fs.joinpath(data, "lazy"),
  })
end, { desc = "Find in plugin files" })

vim.keymap.set("n", "<space>sg", require("custom.telescope.multigrep"), { desc = "Multigrep search in files" })
vim.keymap.set("n", "<leader>fR", builtin.resume, { desc = "Resume search" })
vim.keymap.set("n", "<leader>sR", builtin.resume, { desc = "Resume search" })
