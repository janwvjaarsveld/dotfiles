-- alternatively you can override the default configs
require("flutter-tools").setup({
	decorations = {
		statusline = {
			-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
			-- this will show the current version of the flutter app from the pubspec.yaml file
			app_version = false,
			-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
			-- this will show the currently running device if an application was started with a specific
			-- device
			device = true,
		},
	},
	-- debugger = {
	-- 	enabled = true,
	-- 	run_via_dap = true,
	-- 	exception_breakpoints = {},
	-- 	register_configurations = function(_)
	-- 		require("dap").configurations.dart = {}
	-- 		require("dap.ext.vscode").load_launchjs()
	-- 	end,
	-- },
	widget_guides = {
		enabled = true,
	},
	dev_tools = {
		autostart = false, -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	outline = {
		open_cmd = "30vnew", -- command to use to open the outline buffer
		auto_open = false, -- if true this will open the outline automatically when it is first populated
	},
	lsp = {
		color = { -- show the derived colours for dart variables
			enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
			background = false, -- highlight the background
			foreground = false, -- highlight the foreground
			virtual_text = true, -- show the highlight using virtual text
			virtual_text_str = "■", -- the virtual text character to highlight
		},
		on_attach = require("jw.lsp.handlers").on_attach,
		capabilities = require("jw.lsp.handlers").capabilities, -- e.g. lsp_status capabilities
	},
})
