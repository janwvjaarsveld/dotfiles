return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = 20,
    hide_numbers = true,
    open_mapping = [[<C-\>]],
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 0.3,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    direction = "float",
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end,
    },
  },
}
