return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "json",
      "luadoc",
      "markdown",
      "regex",
      "tsx",
      "typescript",
      "vimdoc",
      "yaml",
      "go",
      "gomod",
      "gowork",
      "gosum",
    })
  end,
}
