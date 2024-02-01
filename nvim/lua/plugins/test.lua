return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-vim-test",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-python",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>tw",
        function()
          require("neotest").run.run({ jestCommand = "jest --watch " })
        end,
        desc = "Run Watch",
      },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
      table.insert(opts.adapters, require("neotest-vitest"))
      table.insert(opts.adapters, require("neotest-plenary"))
      table.insert(opts.adapters, require("neotest-rust"))
      table.insert(opts.adapters, require("neotest-jest"))
      table.insert(
        opts.adapters,
        require("neotest-vim-test")({
          ignore_file_types = { "python", "vim", "lua" },
        })
      )
      table.insert(
        opts.adapters,
        require("neotest-python")({
          dap = { justMyCode = false },
          runner = "unittest",
        })
      )
      table.insert(
        opts.adapters,
        require("neotest-go")({
          args = { "-tags=integration" },
        })
      )
    end,
  },
}
