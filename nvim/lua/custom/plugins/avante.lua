return {
  {
    "yetone/avante.nvim",
    build = "make",

    -- Core configuration
    opts = {
      -- provider = "openai",
      -- auto_suggestions_provider = "openai",
      -- openai = {
      --   model = "gpt-4o-mini",
      -- },
      --
      provider = "claude",
      auto_suggestions_provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
      },
    },

    -- Required dependencies
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",

      -- Markdown rendering
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "Avante" } },
        ft = { "Avante" },
      },
    },
  },
}
