require("custom.snippets")

vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local kind_formatter = lspkind.cmp_format({
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "text_symbol",
  menu = {
    buffer = "[buf]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[api]",
    path = "[path]",
    luasnip = "[snip]",
    gh_issues = "[issues]",
    tn = "[TabNine]",
    eruby = "[erb]",
  },
})

-- Add tailwindcss-colorizer-cmp as a formatting source
require("tailwindcss-colorizer-cmp").setup({
  color_square_width = 2,
})

local cmp = require("cmp")

local cmp_sources = {
  {
    name = "lazydev",
    -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
    group_index = 0,
  },
  { name = "copilot" },
  { name = "nvim_lsp" },
  { name = "path" },
  { name = "buffer" },
}

cmp.setup({
  sources = cmp_sources,
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },

  -- Enable luasnip to handle snippet expansion for nvim-cmp
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },

  formatting = {
    fields = { "abbr", "kind", "menu" },
    expandable_indicator = true,
    format = function(entry, vim_item)
      -- Lspkind setup for icons
      vim_item = kind_formatter(entry, vim_item)

      -- Tailwind colorizer setup
      vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

      local icons = Global.icons.kinds
      if icons[vim_item] then
        vim_item.kind = icons[vim_item.kind] or vim_item.kind
      end

      local widths = {
        abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
        menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
      }

      for key, width in pairs(widths) do
        if vim_item[key] and vim.fn.strdisplaywidth(vim_item[key]) > width then
          vim_item[key] = vim.fn.strcharpart(vim_item[key], 0, width - 1) .. "…"
        end
      end

      return vim_item
    end,
  },

  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  window = {
    -- TODO: I don't like this at all for completion window, it takes up way too much space.
    --  However, I think the docs one could be OK, but I need to fix the highlights for it
    --
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
  completion = { completeopt = "menu,menuone,noselect" },
  preselect = cmp.PreselectMode.None,
})

-- Setup up vim-dadbod
cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})
