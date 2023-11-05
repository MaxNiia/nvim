return {
	{
		"romgrk/barbar.nvim",
		lazy = true,
		event = "BufEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/which-key.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		opts = {
			diagnostics = {
				-- you can use a list
				{ enabled = true, icon = "" }, -- ERROR
				{ enabled = true, icon = "" }, -- WARN
				{ enabled = true, icon = "" }, -- INFO
				{ enabled = false, icon = "" }, -- HINT
			},
			icons = "both",
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.register({
				["<a-,>"] = {
					"<cmd>BufferPrevious<CR>",
					"Prev Buffer",
				},
				["<a-.>"] = {
					"<md>BufferNext<CR>",
					"Next Buffer",
				},
				["<a-1>"] = {
					"<cmd>BufferGoto 1<CR>",
					"1",
				},
				["<a-2>"] = {
					"<cmd>BufferGoto 2<CR>",
					"2",
				},
				["<a-3>"] = {
					"<cmd>BufferGoto 3<CR>",
					"3",
				},
				["<a-4>"] = {
					"<cmd>BufferGoto 4<CR>",
					"4",
				},
				["<a-5>"] = {
					"<cmd>BufferGoto 5<CR>",
					"5",
				},
				["<a-6>"] = {
					"<cmd>BufferGoto 6<CR>",
					"6",
				},
				["<a-7>"] = {
					"<cmd>BufferGoto 7<CR>",
					"7",
				},
				["<a-8>"] = {
					"<cmd>BufferGoto 8<CR>",
					"8",
				},
				["<a-9>"] = {
					"<cmd>BufferGoto 10<CR>",
					"9",
				},
				["<a-0>"] = {
					"<cmd>BufferLast<CR>",
					"Last",
				},
				["<a-i>"] = {
					"<cmd>BufferPin<CR>",
					"Pin Buffer",
				},
				["<a-c>"] = {
					"<cmd>BufferClose<CR>",
					"Close Buffer",
				},
				["<leader>"] = {
					b = {
						name = "Bufferline",
						b = {
							"<cmd>BufferOrderByBufferNumber<CR>",
							"Sort by Buffer number",
						},
						d = {
							"<cmd>BufferOrderByDirectory<CR>",
							"Sort by Directory",
						},
						l = {
							"<cmd>BufferOrderByLanguage<CR>",
							"Sort by Language",
						},
						w = {
							"<cmd>BufferOrderByWindowNumber<CR>",
							"Sort by Window number",
						},
					},
				},
				["<c-p>"] = {
					"<cmd>BufferPick<CR>",
					"Pick Buffer",
				},
				["<a-p>"] = {
					"<cmd>BufferPickDelete<CR>",
					"Pick Buffer Delete",
				},
			}, {})

			require("bufferline").setup(opts)

			local nvim_tree_events = require("nvim-tree.events")
			local bufferline_api = require("bufferline.api")

			local function get_tree_size()
				return require("nvim-tree.view").View.width
			end

			nvim_tree_events.subscribe("TreeOpen", function()
				bufferline_api.set_offset(get_tree_size())
			end)

			nvim_tree_events.subscribe("Resize", function()
				bufferline_api.set_offset(get_tree_size())
			end)

			nvim_tree_events.subscribe("TreeClose", function()
				bufferline_api.set_offset(0)
			end)
		end,
	},
}
