local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local group_name = "lsp_format_on_save"
local group = vim.api.nvim_create_augroup(group_name, { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

local function enable_format_on_save()
	vim.api.nvim_create_autocmd(event, {
		group = group,
		callback = function()
			vim.lsp.buf.format({ async = false })
		end,
		desc = "[lsp] format on save",
	})
	vim.notify("Enabled format on save")
end

local function remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

local function disable_format_on_save()
	remove_augroup(group_name)
	vim.notify("Disabled format on save")
end

local function toggle_format_on_save()
	if vim.fn.exists("#" .. group_name .. "#" .. event) == 0 then
		enable_format_on_save()
	else
		disable_format_on_save()
	end
end

vim.api.nvim_create_user_command("LspToggleAutoFormat", toggle_format_on_save, {
	desc = "Toggle format on save",
})
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier,
		formatting.dart_format,
		formatting.stylua,
		formatting.shfmt,
		formatting.google_java_format,
		-- diagnostics.flake8,
		diagnostics.shellcheck,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>ff", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd(event, {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = async })
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>ff", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
})

local unwrap = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "rust" },
	generator = {
		fn = function(params)
			local diagnostics = {}
			-- sources have access to a params object
			-- containing info about the current file and editor state
			for i, line in ipairs(params.content) do
				local col, end_col = line:find("unwrap()")
				if col and end_col then
					-- null-ls fills in undefined positions
					-- and converts source diagnostics into the required format
					table.insert(diagnostics, {
						row = i,
						col = col,
						end_col = end_col,
						source = "unwrap",
						message = "hey " .. os.getenv("USER") .. ", don't forget to handle this",
						severity = 2,
					})
				end
			end
			return diagnostics
		end,
	},
}

null_ls.register(unwrap)

-- Reuse the Mason registered formatters and LSP server in null-ls,
-- easiest way is the use of jay-babu/mason-null-ls.nvim package.
-- see documentation of null-null-ls for more configuration options!
local mason_nullls_ok, mason_nullls = pcall(require, "mason-null-ls")
if not mason_nullls_ok then
	return
end
mason_nullls.setup({
	automatic_installation = true,
	automatic_setup = true,
})
mason_nullls.setup_handlers({})
