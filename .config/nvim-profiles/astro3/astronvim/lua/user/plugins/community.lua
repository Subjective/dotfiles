return {
	"AstroNvim/astrocommunity",
	-- language packs
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.tailwindcss" },

	-- colorschemes
	{ import = "astrocommunity.colorscheme.tokyonight" },
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.colorscheme.gruvbox" },

	-- ui
	{ import = "astrocommunity.markdown-and-latex.glow-nvim" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },
	{ import = "astrocommunity.media.vim-wakatime" },
	-- { import = "astrocommunity.indent.indent-blankline-nvim" },
	-- { import = "astrocommunity.indent.mini-indentscope" },

	{
		event = "VeryLazy",
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = {
				"*",
				javascriptreact = { names = true, tailwind = true },
				javascript = { names = true, tailwind = true },
				typescript = { names = true, tailwind = true },
				typescriptreact = { names = true, tailwind = true },
				"!javascriptreact",
				"!javascript",
				"!typescript",
				"!typescriptreact",
				"!cmp_menu",
			},
			user_default_options = {
				RRGGBBAA = true,
				AARRGGBB = true,
				-- mode = "virtualtext",
				names = false,
				tailwind = true,
			},
		},
	},
}