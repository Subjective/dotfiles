return {
	-- Configure require("lazy").setup() options
	defaults = { lazy = true },
	performance = {
		rtp = {
			-- customize default disabled vim plugins
			disabled_plugins = {
				"tohtml",
				"gzip",
				-- "matchit",
				"zipPlugin",
				"netrwPlugin",
				"tarPlugin",
				"matchparen",
			},
		},
	},
}
