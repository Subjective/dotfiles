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
}
