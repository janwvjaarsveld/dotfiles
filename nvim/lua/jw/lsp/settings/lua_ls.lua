return {
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			hint = {
				enable = true,
				arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
				await = true,
				paramName = "Disable", -- "All", "Literal", "Disable"
				paramType = false,
				semicolon = "Disable", -- "All", "SameLine", "Disable"
				setType = true,
			},
			-- spell = {"the"}
			runtime = {
				version = "LuaJIT",
				special = {
					reload = "require",
				},
			},
			diagnostics = {
				globals = { "vim", "require" },
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
