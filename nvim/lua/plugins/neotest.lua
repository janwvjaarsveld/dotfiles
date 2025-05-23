return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      discovery = {
        enabled = true,
        filter_dir = function(name, _, _)
          return name ~= "dist"
        end,
      },
      quickfix = {
        enabled = true,
        open = true,
      },
      output_panel = {
        enabled = true,
        -- open = "rightbelow vsplit | resize 30",
      },
      status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      },
      adapters = {
        ["neotest-jest"] = {
          strategy_config = function(default_strategy, _)
            default_strategy["resolveSourceMapLocations"] = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            }
            return default_strategy
          end,
          jest_test_discovery = true,
          jestCommand = function(file)
            -- if string.find(file, "/packages/") then
            --   return "npx nx test:unit "
            -- end
            return "npx jest "
          end,
          jestConfigFile = function(file)
            if string.find(file, "/packages/") then
              if string.find(file, "/src/") then
                return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
              end
              return string.match(file, "(.-/[^/]+/)lib") .. "jest.config.ts"
            end

            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          env = { CI = true },
          cwd = function(file)
            if string.find(file, "/packages/") then
              if string.find(file, "/src/") then
                return string.match(file, "(.-/[^/]+/)src")
              end
              return string.match(file, "(.-/[^/]+/)lib")
            end
            return vim.fn.getcwd()
          end,
        },
        ["neotest-go"] = {
          recursive_run = true,
        },
      },
    },
  },
}
