local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end
vim.opt.rtp:prepend(lazypath)

---@param opts LazyConfig
return function(opts)
  opts = vim.tbl_deep_extend("force", {
    spec = {
      {
        "LazyVim/LazyVim",
        import = "lazyvim.plugins",
        opts = {
          news = {
            lazyvim = false,
            neovim = true,
          },
          colorscheme = "nightfly",
        },
      },
      { import = "plugins.coding" },
      { import = "plugins.editor" },
      { import = "plugins.lsp" },
      { import = "plugins.mini" },
      { import = "plugins.telescope" },
      { import = "plugins.tools" },
      { import = "plugins.ui" },
    },
    defaults = { lazy = false },
    checker = { enabled = false },
    diff = {
      cmd = "terminal_git",
    },
    rocks = { hererocks = true },
    performance = {
      cache = {
        enabled = false,
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "rplugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    debug = false,
  }, opts or {})
  require("lazy").setup(opts)
end
