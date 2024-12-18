return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
  },
  opts = {
    discovery = {
      enabled = true,
    },
    adapters = {
      ["neotest-jest"] = {
        jest_test_discovery = false,
        jestCommand = "npx jest",
        jestConfigFile = function(file)
          if string.find(file, "/packages/") then
            return string.match(file, "(.-/[^/]+/)lib") .. "jest.config.ts"
          end
          if string.find(file, "/src/") then
            return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
          end
          return vim.fn.getcwd() .. "/jest.config.ts"
        end,
        env = { CI = true },
        cwd = function(file)
          if string.find(file, "/packages/") then
            return string.match(file, "(.-/[^/]+/)lib")
          end
          if string.find(file, "/src/") then
            return string.match(file, "(.-/[^/]+/)src")
          end
          return vim.fn.getcwd()
        end,
      },
    },
  },
}
