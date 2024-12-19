local Plugin = require("lazy.core.plugin")
print "Loading util.plugin"

---@class util.plugin
local M = {}

---@type string[]
M.core_imports = {}

M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

---@type table<string, string>

---@type table<string, string>
M.renames = {
  ["windwp/nvim-spectre"] = "nvim-pack/nvim-spectre",
  ["jose-elias-alvarez/null-ls.nvim"] = "nvimtools/none-ls.nvim",
  ["null-ls.nvim"] = "none-ls.nvim",
  ["romgrk/nvim-treesitter-context"] = "nvim-treesitter/nvim-treesitter-context",
  ["glepnir/dashboard-nvim"] = "nvimdev/dashboard-nvim",
  ["markdown.nvim"] = "render-markdown.nvim",
}

function M.save_core()
  if vim.v.vim_did_enter == 1 then
    return
  end
  M.core_imports = vim.deepcopy(require("lazy.core.config").spec.modules)
end

function M.setup()
  M.fix_imports()
  M.fix_renames()
  M.lazy_file()
end

function M.extra_idx(name)
  local Config = require("lazy.core.config")
  for i, extra in ipairs(Config.spec.modules) do
    if extra == "plugins.extras." .. name then
      return i
    end
  end
end

function M.lazy_file()
  -- Add support for the LazyFile event
  local Event = require("lazy.core.handler.event")

  Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
  Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end

function M.fix_imports()
  Plugin.Spec.import = Util.inject.args(Plugin.Spec.import, function(_, spec)
  end)
end

function M.fix_renames()
  Plugin.Spec.add = Util.inject.args(Plugin.Spec.add, function(self, plugin)
    if type(plugin) == "table" then
      if M.renames[plugin[1]] then
        Util.warn(
          ("Plugin `%s` was renamed to `%s`.\nPlease update your config for `%s`"):format(
            plugin[1],
            M.renames[plugin[1]],
            self.importing or "LazyVim"
          ),
          { title = "LazyVim" }
        )
        plugin[1] = M.renames[plugin[1]]
      end
    end
  end)
end

return M
