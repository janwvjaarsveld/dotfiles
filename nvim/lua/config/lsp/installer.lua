require("mason").setup({
     ui = {
         icons = {
             package_installed = "✓"
         }
     }
 })
require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "rust_analyzer", "dockerls", "cssls", "eslint", "gopls", "graphql", "html", "jsonls", "tsserver" ,"pyright", "terraformls", "yamlls"}
})
local lspconfig = require("lspconfig")
-- local lsp_installer_servers = require("nvim-lsp-installer.servers")
-- local utils = require("utils")

local M = {}

function M.setup(servers, options)
  for server_name, _ in pairs(servers) do
    lspconfig[server_name].setup(options)
    -- local server_available, server = lsp_installer_servers.get_server(server_name)
    --
    -- if server_available then
    --   server:on_ready(function()
    --     local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})
    --     server:setup(opts)
    --   end)
    --
    --   if not server:is_installed() then
    --     utils.info("Installing " .. server.name)
    --     server:install()
    --   end
    -- else
    --   utils.error(server)
    -- end
  end
end

return M
