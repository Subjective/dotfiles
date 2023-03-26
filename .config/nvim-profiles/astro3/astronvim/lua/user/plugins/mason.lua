local utils = require("astrocommunity.utils")

return {
	-- use mason-lspconfig to configure LSP installations
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			-- Ensure that opts.ensure_installed exists and is a table.
			if not opts.ensure_installed then
				opts.ensure_installed = {}
			end
			-- Add tsserver to opts.ensure_installed using vim.list_extend.
			utils.list_insert_unique(opts.ensure_installed, "lua_ls", "tsserver", "tailwindcss", "vimls", "clangd")
		end,
	},
	-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
	{
		"jay-babu/mason-null-ls.nvim",
		opts = function(_, opts)
			-- Ensure that opts.ensure_installed exists and is a table.
			if not opts.ensure_installed then
				opts.ensure_installed = {}
			end
			-- Add to opts.ensure_installed using vim.list_extend.
			utils.list_insert_unique(opts.ensure_installed, { "stylua" })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			-- Ensure that opts.ensure_installed exists and is a table.
			if not opts.ensure_installed then
				opts.ensure_installed = {}
			end
			-- Add to opts.ensure_installed using table.insert.
			utils.list_insert_unique(opts.ensure_installed, "python")
		end,
	},
}
