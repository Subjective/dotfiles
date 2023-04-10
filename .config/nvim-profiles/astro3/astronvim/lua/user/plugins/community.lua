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
				javascriptreact = { names = true, tailwind = "both" },
				javascript = { names = true, tailwind = "both" },
				typescript = { names = true, tailwind = "both" },
				typescriptreact = { names = true, tailwind = "both" },
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
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			integrations = {
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
		},
	},
}
