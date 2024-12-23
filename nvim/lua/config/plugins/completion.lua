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
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    -- "saadparwaiz1/cmp_luasnip",
  },
  opts = function(_, opts)
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- local luasnip = require("luasnip")
    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
        keyword_length = 1,
      },
      -- snippet = {
      --   expand = function(args)
      --     require("luasnip").lsp_expand(args.body)
      --   end,
      -- },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- elseif luasnip.expand_or_jumpable() then
            --   luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then
            --   luasnip.jump(-1)
          else
            fallback()
          end
        end),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = opts.sources,
    }
  end,
}
