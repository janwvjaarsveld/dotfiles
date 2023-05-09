local M = {}

vim.o.completeopt = "menu,menuone,noselect"

-- local types = require("cmp.types")
local compare = require("cmp.config.compare")
local lspkind = require("lspkind")

local source_mapping = {
	nvim_lsp = "[Lsp]",
	luasnip = "[Snip]",
	buffer = "[Buffer]",
	nvim_lua = "[Lua]",
	treesitter = "[Tree]",
	path = "[Path]",
	rg = "[Rg]",
	nvim_lsp_signature_help = "[Sig]",
}

function M.setup()
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local luasnip = require("luasnip")
	local neogen = require("neogen")
	local cmp = require("cmp")

	-- local icons = require("config.icons")
	-- local kind_icons = icons.kind

	require("luasnip/loaders/from_vscode").lazy_load()

	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
	vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
	vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
	vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#569CD6" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#569CD6" })
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C586C0" })
	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#C586C0" })
	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9CDCFE" })
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#D4D4D4" })

	vim.g.cmp_active = true

	local select_opts = { behavior = cmp.SelectBehavior.Select }
	local cmp_mapping = {
		["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(select_opts), { "i", "c" }),
		["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(select_opts), { "i", "c" }),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- toggle completion
		["<C-e>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.abort()
			else
				cmp.complete()
			end
		end),
		-- go to next placeholder in the snippet
		["<C-d>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- go to previous placeholder in the snippet
		["<C-s>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-a>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "c" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif neogen.jumpable() then
				neogen.jump_next()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"c",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif neogen.jumpable(true) then
				neogen.jump_prev()
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"c",
		}),
	}

	local buffer_fts = {
		"markdown",
		"toml",
		"yaml",
		"json",
	}

	local function contains(t, value)
		for _, v in pairs(t) do
			if v == value then
				return true
			end
		end
		return false
	end

	cmp.setup({
		enabled = function()
			local buftype = vim.api.nvim_buf_get_option(0, "buftype")
			if buftype == "prompt" then
				return false
			end
			return vim.g.cmp_active
		end,
		preselect = cmp.PreselectMode.Item,
		completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
		experimental = {
			ghost_text = true,
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				-- require "cmp_tabnine.compare",
				compare.score,
				compare.recently_used,
				compare.locality,
				compare.offset,
				compare.exact,
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
			},
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 40,

				before = function(entry, vim_item)
					vim_item.kind = lspkind.presets.default[vim_item.kind]

					local menu = source_mapping[entry.source.name]
					vim_item.menu = menu

					-- if entry.source.name == "copilot" then
					-- 	vim_item.kind = icons.git.Octoface
					-- 	vim_item.kind_hl_group = "CmpItemKindCopilot"
					-- end

					-- if entry.source.name == "emoji" then
					-- 	vim_item.kind = icons.misc.Smiley
					-- 	vim_item.kind_hl_group = "CmpItemKindEmoji"
					-- end

					-- if entry.source.name == "crates" then
					-- 	vim_item.kind = icons.misc.Package
					-- 	vim_item.kind_hl_group = "CmpItemKindCrate"
					-- end

					-- if entry.source.name == "lab.quick_data" then
					-- 	vim_item.kind = icons.misc.CircuitBoard
					-- 	vim_item.kind_hl_group = "CmpItemKindConstant"
					-- end

					-- -- NOTE: order matters
					-- vim_item.menu = ({
					-- 	nvim_lsp = "",
					-- 	nvim_lua = "",
					-- 	luasnip = "",
					-- 	buffer = "",
					-- 	path = "",
					-- 	emoji = "",
					-- })[entry.source.name]
					return vim_item
				end,
			}),
			fields = { "kind", "abbr", "menu" },
		},
		mapping = cmp.mapping.preset.insert(cmp_mapping),
		sources = {
			{ name = "crates", group_index = 1 },
			{
				name = "copilot",
				-- keyword_length = 0,
				max_item_count = 3,
				trigger_characters = {
					{
						".",
						":",
						"(",
						"'",
						'"',
						"[",
						",",
						"#",
						"*",
						"@",
						"|",
						"=",
						"-",
						"{",
						"/",
						"\\",
						"+",
						"?",
						" ",
					},
				},
				group_index = 2,
			},
			{
				name = "nvim_lsp",
				max_item_count = 15,
				filter = function(entry, ctx)
					local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
					if kind == "Snippet" and ctx.prev_context.filetype == "java" then
						return true
					end

					if kind == "Text" then
						return true
					end
				end,
				group_index = 2,
			},
			{ name = "nvim_lsp_signature_help", max_item_count = 5 },
			{ name = "nvim_lua", group_index = 2 },
			{ name = "luasnip", group_index = 2, max_item_count = 5 },
			{
				name = "buffer",
				group_index = 2,
				max_item_count = 5,
				filter = function(entry, ctx)
					if not contains(buffer_fts, ctx.prev_context.filetype) then
						return true
					end
				end,
			},
			{ name = "path", group_index = 2 },
			{ name = "emoji", group_index = 2 },
			{ name = "treesitter", max_item_count = 5 },
			{ name = "rg", max_item_count = 2 },
			{ name = "lab.quick_data", keyword_length = 4, group_index = 2 },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
			},
			-- documentation = false,
			-- completion = {
			-- 	border = "rounded",
			-- 	winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
			-- },
		},
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.insert(cmp_mapping),
		sources = cmp.config.sources({
			{ name = "nvim_lua" },
		}, {
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	-- Auto pairs
	-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return M
