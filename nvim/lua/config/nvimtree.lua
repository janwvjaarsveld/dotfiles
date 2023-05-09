local M = {}

function M.setup()
	local lib = require("nvim-tree.lib")

	local git_stage = function()
		local node = lib.get_node_at_cursor()
		local gs = node.git_status

		-- If the file is untracked, unstaged or partially staged, we stage it
		if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
			vim.cmd("silent !git add " .. node.absolute_path)

		-- If the file is staged, we unstage
		elseif gs == "M " or gs == "A " then
			vim.cmd("silent !git restore --staged " .. node.absolute_path)
		end

		lib.refresh_tree()
	end
	local nvim_tree = require("nvim-tree")
	nvim_tree.setup({
		disable_netrw = false,
		hijack_netrw = true,
		respect_buf_cwd = true,
		filters = {
			custom = { ".git" },
		},
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		sort_by = "case_sensitive",
		view = {
			side = "right",
			adaptive_size = true,
			mappings = {
				list = {
					{ key = "u", action = "dir_up" },
					{ key = "<tab>", action = "git_stage", action_cb = git_stage },
				},
			},
			number = true,
			relativenumber = true,
			float = {
				enable = true,
				quit_on_focus_loss = true,
				open_win_config = {
					relative = "editor",
					border = "rounded",
					width = 30,
					height = 100,
					row = 1,
					col = 1,
				},
			},
		},
		renderer = {
			group_empty = true,
			icons = {
				webdev_colors = true,
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
				glyphs = {
					git = {
						unstaged = "✗",
						staged = "✚",
						unmerged = "═",
						renamed = "➜",
						untracked = "★",
						deleted = "␡",
						ignored = "◌",
					},
				},
			},
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
	})
end

return M
