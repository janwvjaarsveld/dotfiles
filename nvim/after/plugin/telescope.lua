local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = "> ",
		color_devicons = true,

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-q>"] = actions.send_to_qflist,
				["<CR>"] = actions.select_default,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-p>"] = actions.preview_scrolling_up,
				["<C-n>"] = actions.preview_scrolling_down,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

require("telescope").load_extension("git_worktree")

local function reload_modules()
	-- Because TJ gave it to me.  Makes me happpy.  Put it next to his other
	-- awesome things.
	local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
	for _, dir in ipairs(lua_dirs) do
		dir = string.gsub(dir, "./lua/", "")
		require("plenary.reload").reload_module(dir)
	end
end

local function search_dotfiles()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end

local function git_branches(opts)
	opts = opts or {}
	opts.attach_mappings =
		function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end, require("telescope.builtin").git_branches(opts)
end

local dropdownTheme = require("telescope.themes").get_dropdown

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<C-p>", function()
	require("telescope.builtin").git_files()
end, { desc = "[C-p] Search Git Files" })
vim.keymap.set("n", "<leader>sdf", function()
	search_dotfiles()
end, { desc = "[S]earch [D]ot[F]iles" })
vim.keymap.set("n", "<leader>gb", function()
	git_branches(dropdownTheme())
end, { desc = "[G]it [B]ranches" })
vim.keymap.set("n", "<leader>gw", function()
	require("telescope").extensions.git_worktree.git_worktrees(dropdownTheme())
end, { desc = "[G]it [W]orktrees" })
vim.keymap.set("n", "<leader>gcw", function()
	require("telescope").extensions.git_worktree.create_git_worktree(dropdownTheme())
end, { desc = "[G]it [C]reate [W]orktree" })
vim.keymap.set("n", "<leader>gs", function()
	require("telescope.builtin").git_status(dropdownTheme())
end, { desc = "[G]it [S]tatus" })
