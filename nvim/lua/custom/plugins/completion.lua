return {
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     "giuxtaposition/blink-cmp-copilot",
  --   },
  --   version = "v0.*",
  --
  --   opts = {
  --     keymap = {
  --       -- preset = "default",
  --       ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  --       ["<C-e>"] = { "hide", "fallback" },
  --       -- ["<CR>"] = {
  --       --   function(cmp)
  --       --     return cmp.select_and_accept()
  --       --   end,
  --       --   "fallback",
  --       -- },
  --
  --       ["<Tab>"] = {
  --         function(cmp)
  --           if cmp.snippet_active() then
  --             return cmp.accept()
  --           else
  --             return cmp.ac()
  --           end
  --         end,
  --         "snippet_forward",
  --         "fallback",
  --       },
  --       ["<S-Tab>"] = {
  --         function(cmp)
  --           return cmp.select_prev()
  --         end,
  --         "snippet_backward",
  --         "fallback",
  --       },
  --
  --       ["<Up>"] = { "select_prev", "fallback" },
  --       ["<Down>"] = { "select_next", "fallback" },
  --       ["<C-p>"] = { "select_prev", "fallback" },
  --       ["<C-n>"] = { "select_next", "fallback" },
  --
  --       ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  --       ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  --     },
  --
  --     appearance = {
  --       use_nvim_cmp_as_default = true,
  --       nerd_font_variant = "mono",
  --     },
  --
  --     -- experimental signature help support
  --     signature = { enabled = true },
  --     -- default list of enabled providers defined so that you can extend it
  --     -- elsewhere in your config, without redefining it, via `opts_extend`
  --     sources = {
  --       default = { "lsp", "path", "snippets", "buffer", "copilot" },
  --       providers = {
  --         copilot = {
  --           name = "copilot",
  --           module = "blink-cmp-copilot",
  --           score_offset = 100,
  --           async = true,
  --         },
  --       },
  --       -- optionally disable cmdline completions
  --       -- cmdline = {},
  --     },
  --   },
  --   -- allows extending the providers array elsewhere in your config
  --   -- without having to redefine it
  --   opts_extend = { "sources.default" },
  -- },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true },
        panel = { enabled = false },
      })

      require("copilot_cmp").setup()

      require("custom.completion")
    end,
  },
}
