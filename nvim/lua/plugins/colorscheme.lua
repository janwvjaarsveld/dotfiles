-- material theme option
vim.g.material_style = "deep ocean"

return {
  -- add OneDarker
  { "lunarvim/Onedarker.nvim" },
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- add midnight
  { "dasupradyumna/midnight.nvim" },
  -- add material
  { "marko-cerovac/material.nvim" },
  -- add embark
  { "embark-theme/vim", as = "embark" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material",
    },
  },
}
