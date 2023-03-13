local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local icons = require("jw.icons")
	local signs = {

		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_lines = true,
		virtual_text = false,
		-- virtual_text = {
		--   -- spacing = 7,
		--   -- update_in_insert = false,
		--   -- severity_sort = true,
		--   -- prefix = "<-",
		--   prefix = " ●",
		--   source = "if_many", -- Or "always"
		--   -- format = function(diag)
		--   --   return diag.message .. "blah"
		--   -- end,
		-- },

		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "if_many", -- Or "always"
			header = "",
			prefix = "",
			-- width = 40,
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		-- width = 60,
		-- height = 30,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		-- width = 60,
		-- height = 30,
	})
end

local function attach_navic(client, bufnr)
	vim.g.navic_silence = true
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
		return
	end
	navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
	local fmt = function(cmd)
		return function(str)
			return cmd:format(str)
		end
	end
	local buf = fmt("<cmd>lua vim.lsp.buf.%s<CR>")
	local telescope = fmt("<cmd>Telescope %s<CR>")
	local cmd = fmt("<cmd>%s<CR>")
	local diagnostic = fmt("<cmd>lua vim.diagnostic.%s<CR>")

	-- local lsp = fmt('<cmd>lua vim.lsp.%s<cr>')
	local omit = {}

	local map = function(m, lhs, rhs)
		if omit[lhs] then
			return
		end

		local key_opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, m, lhs, rhs, key_opts)
	end

	map("n", "gd", telescope("lsp_definitions"))
	map("n", "gD", telescope("lsp_declarations"))
	map("n", "K", buf("hover()"))
	map("n", "gi", telescope("lsp_implementations"))
	map("n", "gtd", telescope("lsp_type_definitions"))
	map("n", "gr", telescope("lsp_references"))
	map("n", "vd", diagnostic("open_float()"))
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
	map("n", "<leader>ff", cmd("Format"))
	map("n", "<leader>ca", buf("code_action()"))
	map("i", "<C-h>", buf("signature_help()"))
	map("n", "<C-h>", buf("signature_help()"))
	map("n", "<leader>rn", buf("rename()"))
	map("n", "<leader>ca", buf("code_action()"))
	map("n", "[d", diagnostic('goto_prev({ border = "rounded" })'))
	map("n", "]d", diagnostic('goto_next({ border = "rounded" })'))
end

M.on_attach = function(client, bufnr)
	print("LSP attached to " .. client.name)
	lsp_keymaps(bufnr)
	attach_navic(client, bufnr)

	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "eslint" then
		vim.cmd.LspStop("eslint")
		return
	end

	if client.name == "jdt.ls" then
		vim.lsp.codelens.refresh()
		if JAVA_DAP_ACTIVE then
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
		end
	end
end

return M
