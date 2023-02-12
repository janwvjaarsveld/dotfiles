local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local servers = {
	"cssls",
	"cssmodules_ls",
	"html",
	"jdtls",
	"jsonls",
	"sumneko_lua",
	"tflint",
	"terraformls",
	"tsserver",
	"pyright",
	"yamlls",
	"bashls",
	"rust_analyzer",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("jw.lsp.handlers").on_attach,
		capabilities = require("jw.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local ok, custom_opts = pcall(require, "jw.lsp.settings." .. server)
	if ok then
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	end

	if server == "rust_analyzer" then
		local rust_opts = require("jw.lsp.settings.rust")
		-- opts = vim.tbl_deep_extend("force", rust_opts, opts)
		local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
		if not rust_tools_status_ok then
			return
		end

		rust_tools.setup(rust_opts)
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
