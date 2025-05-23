return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      auto_close = true,
    },
    bigfile = {},
    image = {
      env = {
        SNACKS_GHOSTTY = true,
      },
      doc = {
        -- enable image viewer for documents
        -- a treesitter parser must be available for the enabled languages.
        enabled = true,
        -- render the image inline in the buffer
        -- if your env doesn't support unicode placeholders, this will be disabled
        -- takes precedence over `opts.float` on supported terminals
        inline = true,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = true,
        max_width = 80,
        max_height = 40,
        -- Set to `true`, to conceal the image text when rendering inline.
        -- (experimental)
        ---@param lang string tree-sitter language
        ---@param type snacks.image.Type image type
        conceal = function(lang, type)
          -- only conceal math expressions
          return type == "math"
        end,
      },
    },
    picker = { sources = { explorer = { layout = { layout = { position = "right" } } } } },
  },
}
