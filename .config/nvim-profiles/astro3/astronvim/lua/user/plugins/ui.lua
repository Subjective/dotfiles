return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.colorscheme.tokyonight" },
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.colorscheme.gruvbox" },
	{ import = "astrocommunity.markdown-and-latex.glow-nvim" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },
	{ import = "astrocommunity.media.vim-wakatime" },
	-- { import = "astrocommunity.indent.indent-blankline-nvim" },
	-- { import = "astrocommunity.indent.mini-indentscope" },
	{
		lazy = false,
		"tokyonight.nvim",
	},
	{
		lazy = false,
		"catppuccin",
	},
	{
		lazy = false,
		"gruvbox.nvim",
		opts = {
			integrations = {
				mini = true,
				leap = true,
				markdown = true,
				cmp = true,
			},
		},
	},
	{
		lazy = false,
		"christoomey/vim-tmux-navigator",
	},
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	enabled = false,
	-- 	event = "VeryLazy",
	-- 	opts = function()
	-- 		-- don't use animate when scrolling with the mouse
	-- 		local mouse_scrolled = false
	-- 		for _, scroll in ipairs({ "Up", "Down" }) do
	-- 			local key = "<ScrollWheel" .. scroll .. ">"
	-- 			vim.keymap.set({ "", "i" }, key, function()
	-- 				mouse_scrolled = true
	-- 				return key
	-- 			end, { expr = true })
	-- 		end
	--
	-- 		local animate = require("mini.animate")
	-- 		return {
	-- 			cursor = {
	-- 				enable = false,
	-- 				timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
	-- 				path = animate.gen_path.line({
	-- 					predicate = function(destination)
	-- 						return destination[1] < -2 or 2 < destination[1]
	-- 					end,
	-- 				}),
	-- 			},
	-- 			resize = {
	-- 				enable = false,
	-- 				timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
	-- 			},
	-- 			scroll = {
	-- 				-- timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
	-- 				timing = function(_, n)
	-- 					return math.min(150 / n, 5)
	-- 				end,
	-- 				subscroll = animate.gen_subscroll.equal({
	-- 					predicate = function(total_scroll)
	-- 						if mouse_scrolled then
	-- 							mouse_scrolled = false
	-- 							return false
	-- 						end
	-- 						return total_scroll > 1
	-- 					end,
	-- 				}),
	-- 			},
	-- 		}
	-- 	end,
	-- 	config = function(_, opts)
	-- 		require("mini.animate").setup(opts)
	-- 	end,
	-- },
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
	},
}
