return {
    {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- 'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
	require("lspconfig").lua_ls.setup {}
    end,
}
}
