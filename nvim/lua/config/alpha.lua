local M = {}

function M.setup()
	local status_ok, alpha = pcall(require, "alpha")
	if not status_ok then
		return
	end

	local dashboard = require("alpha.themes.dashboard")

	local function header()
		return {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}
	end

	dashboard.section.header.val = header

	-- if current directory is dotfiles then add configuration button otherwise add a telescope button
	if vim.fn.getcwd() == vim.env.DOTFILES then
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("t", "  File Tree", ":NvimTreeToggle <CR>"),
			dashboard.button("f", "  Find Files", "<cmd>lua require('utils.finder').find_files()<cr>"),
			dashboard.button("c", "  Configuration", ":e ./nvim/lua/plugins.lua <CR>"),
			dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		}
	else
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("t", "  File Tree", ":NvimTreeToggle <CR>"),
			dashboard.button("f", "  Find Files", "<cmd>lua require('utils.finder').find_files()<cr>"),
			dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		}
	end

	local function footer()
		-- Number of plugins
		local total_plugins = #vim.tbl_keys(packer_plugins)
		local datetime = os.date("%d-%m-%Y %H:%M:%S")
		local plugins_text = "   "
			.. total_plugins
			.. " plugins"
			.. "   v"
			.. vim.version().major
			.. "."
			.. vim.version().minor
			.. "."
			.. vim.version().patch
			.. "   "
			.. datetime

		-- Quote
		local fortune = require("alpha.fortune")
		local quote = table.concat(fortune(), "\n")

		return plugins_text .. "\n" .. quote
	end

	dashboard.section.footer.val = footer()

	dashboard.section.footer.opts.hl = "Constant"
	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Function"
	dashboard.section.buttons.opts.hl_shortcut = "Type"
	dashboard.opts.opts.noautocmd = true

	alpha.setup(dashboard.opts)
end

return M
