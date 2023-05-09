-- Indicate first time installation
local is_bootstrap = false

-- packer.nvim configuration
local conf = {
	profile = {
		enable = true,
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},
	display = {
		title = "Packer",
		done_sym = "",
		error_syn = "×",
		keybindings = {
			toggle_info = "o",
		},
		open_fn = function()
			local result, win, buf = require("packer.util").float({
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},
			})
			vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
			return result, win, buf
		end,
	},
}

-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
-- Install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	is_bootstrap = true
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

-- Automatically source and sync packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = "plugins.lua",
})

require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- Performance
		use({ "lewis6991/impatient.nvim" })

		-- Load only when require
		use({ "nvim-lua/plenary.nvim", module = "plenary" })

		-- Notification
		use({
			"rcarriga/nvim-notify",
			config = function()
				require("config.notify").setup()
			end,
		})

		-- Colorscheme
		use({
			"folke/tokyonight.nvim",
			config = function()
				vim.cmd("colorscheme tokyonight")
			end,
			disable = false,
		})
		use({
			"norcalli/nvim-colorizer.lua",
			cmd = "ColorizerToggle",
			config = function()
				require("colorizer").setup()
			end,
		})

		-- Startup screen
		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		})

		-- Doc
		use({ "nanotee/luv-vimdocs", event = "BufReadPre" })
		use({ "milisims/nvim-luaref", event = "BufReadPre" })

		-- Better Netrw
		use({ "tpope/vim-vinegar" })

		-- Git
		use({ "jreybert/vimagit", cmd = "Magit", disable = true })
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufReadPre",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.gitsigns").setup()
			end,
		})
		use({
			"tpope/vim-fugitive",
			opt = true,
			cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
			requires = {
				"tpope/vim-rhubarb",
				"idanarye/vim-merginal",
			},
		})
		use({
			"rbong/vim-flog",
			cmd = { "Flog", "Flogsplit", "Floggit" },
			wants = { "vim-fugitive" },
		})
		use({
			"pwntester/octo.nvim",
			cmd = "Octo",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"nvim-tree/nvim-web-devicons",
			},
			config = function()
				require("octo").setup()
			end,
			disable = false,
		})
		use({
			"akinsho/git-conflict.nvim",
			cmd = {
				"GitConflictChooseTheirs",
				"GitConflictChooseOurs",
				"GitConflictChooseBoth",
				"GitConflictChooseNone",
				"GitConflictNextConflict",
				"GitConflictPrevConflict",
				"GitConflictListQf",
			},
			config = function()
				require("git-conflict").setup()
			end,
		})
		use({ "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } })
		use({
			"tanvirtin/vgit.nvim",
			config = function()
				require("vgit").setup()
			end,
			cmd = { "VGit" },
		})
		use("ThePrimeagen/git-worktree.nvim")
		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

		-- WhichKey
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			module = { "which-key" },
			-- keys = { [[<leader>]] },
			config = function()
				require("config.whichkey").setup()
			end,
		})

		-- IndentLine
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indentblankline").setup()
			end,
		})

		-- Better icons
		use({
			"nvim-tree/nvim-web-devicons",
			module = "nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({ default = true })
			end,
		})

		-- Better Comment
		use({
			"numToStr/Comment.nvim",
			keys = { "gc", "gcc", "gbc" },
			config = function()
				require("config.comment").setup()
			end,
			disable = false,
		})
		use({ "tpope/vim-commentary", keys = { "gc", "gcc", "gbc" }, disable = true })

		-- Buffer
		use({ "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } })
		use({
			"matbme/JABS.nvim",
			cmd = "JABSOpen",
			config = function()
				require("config.jabs").setup()
			end,
			disable = false,
		})
		use({
			"chentoast/marks.nvim",
			event = "BufReadPre",
			config = function()
				require("marks").setup({})
			end,
		})

		-- Code documentation
		use({
			"danymat/neogen",
			config = function()
				require("config.neogen").setup()
			end,
			cmd = { "Neogen" },
			module = "neogen",
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			opt = true,
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			ft = "markdown",
			cmd = { "MarkdownPreview" },
			requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
		})
		use({
			"jakewvincent/mkdnflow.nvim",
			config = function()
				require("mkdnflow").setup({})
			end,
			ft = "markdown",
		})

		-- Status line
		use({
			"nvim-lualine/lualine.nvim",
			event = "BufReadPre",
			config = function()
				require("config.lualine").setup()
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{ "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
				{ "windwp/nvim-ts-autotag", event = "InsertEnter" },
				{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
				{ "p00f/nvim-ts-rainbow", event = "BufReadPre" },
				{ "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
				{ "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
				{
					"m-demare/hlargs.nvim",
					config = function()
						require("config.hlargs").setup()
					end,
					disable = false,
				},
			},
		})

		-- trouble.nvim
		use({
			"folke/trouble.nvim",
			cmd = { "TroubleToggle", "Trouble" },
			module = { "trouble.providers.telescope" },
			config = function()
				require("trouble").setup({
					use_diagnostic_signs = true,
				})
			end,
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			event = { "VimEnter" },
			config = function()
				require("config.telescope").setup()
			end,
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					run = "make",
				},
				{ "nvim-telescope/telescope-project.nvim" },
				{ "cljoly/telescope-repo.nvim" },
				{ "nvim-telescope/telescope-file-browser.nvim" },
				{
					"nvim-telescope/telescope-frecency.nvim",
					requires = "tami5/sqlite.lua",
				},
				{
					"ahmedkhalf/project.nvim",
					config = function()
						require("config.project").setup()
					end,
				},
				{ "nvim-telescope/telescope-dap.nvim" },
				{
					"AckslD/nvim-neoclip.lua",
					requires = {
						{ "tami5/sqlite.lua", module = "sqlite" },
					},
				},
				{ "nvim-telescope/telescope-smart-history.nvim" },
				{ "nvim-telescope/telescope-media-files.nvim" },
				{ "dhruvmanila/telescope-bookmarks.nvim" },
				{ "nvim-telescope/telescope-github.nvim" },
				{ "jvgrootveld/telescope-zoxide" },
				{ "Zane-/cder.nvim" },
				"nvim-telescope/telescope-symbols.nvim",
			},
		})

		-- nvim-tree
		use({
			"nvim-tree/nvim-tree.lua",
			opt = true,
			cmd = { "NvimTreeToggle", "NvimTreeClose", "NvimTreeFindFile" },
			config = function()
				require("config.nvimtree").setup()
			end,
		})
		use({ "elihunter173/dirbuf.nvim", cmd = { "Dirbuf" } })
		use("mbbill/undotree")

		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			opt = true,
			config = function()
				require("config.cmp").setup()
			end,
			requires = {
				{
					"windwp/nvim-autopairs",
					config = function()
						require("nvim-autopairs").setup({})
					end,
				},
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				{ "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
				{ "hrsh7th/cmp-nvim-lua" },
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"lukas-reineke/cmp-rg",
				"davidsierradz/cmp-conventionalcommits",
				{ "onsails/lspkind-nvim", module = { "lspkind" } },
				{
					"L3MON4D3/LuaSnip",
					config = function()
						require("config.snip").setup()
					end,
					module = { "luasnip" },
				},
				"rafamadriz/friendly-snippets",
				"honza/vim-snippets",
			},
		})

		-- LSP
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				-- "WhoIsSethDaniel/mason-tool-installer.nvim",
				{
					"ray-x/lsp_signature.nvim",
					config = function()
						require("config.lsp.lsp-signature")
					end,
				},
				{ "onsails/lspkind.nvim" },
				{ "jayp0521/mason-null-ls.nvim" },
				"folke/neodev.nvim",
				"RRethy/vim-illuminate",
				"jose-elias-alvarez/null-ls.nvim",
				{
					"j-hui/fidget.nvim",
					config = function()
						require("fidget").setup({})
					end,
				},
				{ "b0o/schemastore.nvim", module = { "schemastore" } },
				{ "jose-elias-alvarez/typescript.nvim", module = { "typescript" } },
				{
					"SmiteshP/nvim-navic",
					-- "alpha2phi/nvim-navic",
					config = function()
						require("nvim-navic").setup({})
					end,
					module = { "nvim-navic" },
				},
				{
					"simrat39/inlay-hints.nvim",
					config = function()
						require("inlay-hints").setup()
					end,
				},
			},
		})

		-- Debugging
		use({
			"mfussenegger/nvim-dap",
			opt = true,
			module = { "dap" },
			requires = {
				{ "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
				{ "rcarriga/nvim-dap-ui", module = { "dapui" } },
				{ "mfussenegger/nvim-dap-python", module = { "dap-python" } },
				{ "nvim-telescope/telescope-dap.nvim" },
				{ "leoluz/nvim-dap-go", module = "dap-go" },
				{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
				{ "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
				{
					"microsoft/vscode-js-debug",
					opt = true,
					run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
					disable = false,
				},
			},
			config = function()
				require("config.dap").setup()
			end,
			disable = false,
		})

		-- vimspector
		use({
			"puremourning/vimspector",
			cmd = { "VimspectorInstall", "VimspectorUpdate" },
			fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
			config = function()
				require("config.vimspector").setup()
			end,
			disable = true,
		})

		-- Test
		use({
			"nvim-neotest/neotest",
			requires = {
				{
					"stevearc/overseer.nvim",
					config = function()
						require("overseer").setup()
					end,
				},
				{
					"vim-test/vim-test",
					event = { "BufReadPre" },
					config = function()
						require("config.test").setup()
					end,
				},
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				{ "nvim-neotest/neotest-vim-test", module = { "neotest-vim-test" } },
				{ "nvim-neotest/neotest-python", module = { "neotest-python" } },
				{ "nvim-neotest/neotest-plenary", module = { "neotest-plenary" } },
				{ "nvim-neotest/neotest-go", module = { "neotest-go" } },
				{ "haydenmeade/neotest-jest", module = { "neotest-jest" } },
				{ "rouge8/neotest-rust", module = { "neotest-rust" } },
			},
			module = { "neotest", "neotest.async" },
			config = function()
				require("config.neotest").setup()
			end,
			disable = false,
		})
		use({ "diepm/vim-rest-console", ft = { "rest" }, disable = false })

		-- AI completion
		use({ "github/copilot.vim" })

		-- Harpoon
		use({
			"ThePrimeagen/harpoon",
			module = {
				"harpoon",
				"harpoon.cmd-ui",
				"harpoon.mark",
				"harpoon.ui",
				"harpoon.term",
				"telescope._extensions.harpoon",
			},
			config = function()
				require("config.harpoon").setup()
			end,
		})

		-- Refactoring
		use({
			"ThePrimeagen/refactoring.nvim",
			module = { "refactoring", "telescope" },
			keys = { [[<leader>r]] },
			config = function()
				require("config.refactoring").setup()
			end,
		})
		use({ "python-rope/ropevim", run = "pip install ropevim", disable = true })
		use({
			"kevinhwang91/nvim-bqf",
			ft = "qf",
			disable = false,
			config = function()
				require("bqf").setup()
			end,
		})
		use({ "kevinhwang91/nvim-hlslens", event = "BufReadPre", disable = true })
		use({ "nvim-pack/nvim-spectre", module = "spectre", keys = { "<leader>s" } })
		use({
			"https://gitlab.com/yorickpeterse/nvim-pqf",
			event = "BufReadPre",
			config = function()
				require("pqf").setup()
			end,
		})
		use({
			"andrewferrier/debugprint.nvim",
			module = { "debugprint" },
			keys = { "g?p", "g?P", "g?v", "g?V", "g?o", "g?O" },
			cmd = { "DeleteDebugPrints" },
			config = function()
				require("debugprint").setup()
			end,
		})

		--Rust
		use("simrat39/rust-tools.nvim")

		-- Terminal
		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			keys = { [[<C-\>]] },
			cmd = { "ToggleTerm", "TermExec" },
			module = { "toggleterm", "toggleterm.terminal" },
			config = function()
				require("config.toggleterm").setup()
			end,
		})

		use("b0o/schemastore.nvim")
		use({
			"SmiteshP/nvim-navic",
			requires = "neovim/nvim-lspconfig",
		})

		-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
		local has_c_plugins, c_plugins = pcall(require, "custom.plugins")
		if has_c_plugins then
			c_plugins(use)
		end

		if is_bootstrap then
			require("packer").sync()
		end
	end,
	config = conf,
})

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end
