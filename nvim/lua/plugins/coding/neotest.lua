return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
  },
  opts = {
    adapters = {
      ["neotest-jest"] = {
        jestCommand = "npx jest --",
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
    },
  },
}
