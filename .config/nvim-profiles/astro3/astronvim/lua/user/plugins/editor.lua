return {
	{
		"kylechui/nvim-surround",
		lazy = false,
		config = function()
			require("nvim-surround").setup({
				indent_lines = false,
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
		"Exafunction/codeium.vim",
		cmd = "Codeium",
		init = function()
			vim.g.codeium_enabled = 0
			vim.g.codeium_disable_bindings = 1
			vim.g.codeium_idle_delay = 1500
		end,
		config = function()
			vim.keymap.set("i", "<C-;>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<C-->", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<C-=>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<C-BS>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},
}
