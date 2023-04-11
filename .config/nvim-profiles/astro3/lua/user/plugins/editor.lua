return {
	{
		"kylechui/nvim-surround",
		lazy = false,
		config = function()
			require("nvim-surround").setup({
				indent_lines = false,
				keymaps = {
					insert = "<C-g>s",
					insert_line = "<C-g>Z",
					normal = "ys",
					normal_cur = "yss",
					normal_line = "yZ",
					normal_cur_line = "yZZ",
					visual = "Z",
					visual_line = "gZ",
					delete = "ds",
					change = "cs",
				},
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
		dependencies = {
			"ggandor/flit.nvim",
			keys = function()
				---@type LazyKeys[]
				local ret = {}
				for _, key in ipairs({ "f", "F", "t", "T" }) do
					ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
				end
				return ret
			end,
			opts = { labeled_modes = "nx" },
		},
	},
	{
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		opts = function()
			local prefix = "<leader>s"
			return {
				mapping = {
					send_to_qf = { map = prefix .. "q" },
					replace_cmd = { map = prefix .. "c" },
					show_option_menu = { map = prefix .. "o" },
					run_current_replace = { map = prefix .. "C" },
					run_replace = { map = prefix .. "R" },
					change_view_mode = { map = prefix .. "v" },
					resume_last_search = { map = prefix .. "l" },
				},
			}
		end,
	},
}
