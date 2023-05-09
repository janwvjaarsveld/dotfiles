local M = {}

local whichkey = require("which-key")
-- local legendary = require "legendary"

-- local keymap = vim.api.nvim_set_keymap
-- local buf_keymap = vim.api.nvim_buf_set_keymap
local keymap = vim.keymap.set

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true }
	local fmt = function(cmd)
		return function(str)
			return cmd:format(str)
		end
	end
	local buf = fmt("<cmd>lua vim.lsp.buf.%s<CR>")
	local telescope = fmt("<cmd>Telescope %s<CR>")
	local cmd = fmt("<cmd>%s<CR>")
	local diagnostic = fmt("<cmd>lua vim.diagnostic.%s<CR>")

	-- Key mappings
	keymap("n", "K", buf("hover, { buffer = bufnr })"), opts)

	keymap("n", "[d", diagnostic('goto_prev({ border = "rounded" })'), opts)
	keymap("n", "]d", diagnostic('goto_next({ border = "rounded" })'), opts)
	keymap("n", "vd", diagnostic("open_float()"), opts)
	keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	keymap("i", "<C-h>", buf("signature_help()"), opts)
	keymap("n", "<C-h>", buf("signature_help()"), opts)

	-- Whichkey
	local keymap_l = {
		l = {
			name = "LSP",
			R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
			d = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "Diagnostics" },
			f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
			i = { "<cmd>LspInfo<CR>", "Lsp Info" },
			r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "References" },
			s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Document Symbols" },
			t = { "<cmd>TroubleToggle document_diagnostics<CR>", "Trouble" },
			L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
			l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
			D = { "<cmd>lua require('config.lsp').toggle_diagnostics()<CR>", "Toggle Inline Diagnostics" },
		},
	}
	if client.server_capabilities.documentFormattingProvider then
		keymap_l.l.F = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format Document" }
	end

	local keymap_leader = {
		name = "LSP",
	}

	local keymap_g = {
		name = "Goto",
		d = { telescope("lsp_definitions"), "Definition" },
		D = { telescope("lsp_declarations"), "Declaration" },
		i = { telescope("lsp_implementations"), "Goto Implementation" },
		t = { telescope("lsp_type_definitions"), "Goto Type Definition" },
		r = { telescope("lsp_references"), "Goto Reference" },
	}

	local o = { buffer = bufnr, prefix = "<leader>" }
	whichkey.register(keymap_l, o)

	o = { mode = "n", buffer = bufnr, prefix = "<leader>" }
	whichkey.register(keymap_leader, o)

	o = { buffer = bufnr, prefix = "g" }
	whichkey.register(keymap_g, o)
end

function M.setup(client, bufnr)
	keymappings(client, bufnr)
	-- signature_help(client, bufnr) -- use cmp-nvim-lsp-signature-help
end

return M
