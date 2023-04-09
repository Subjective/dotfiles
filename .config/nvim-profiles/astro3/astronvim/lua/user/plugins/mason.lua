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
			utils.list_insert_unique(
				opts.ensure_installed,
				{ "lua_ls", "tsserver", "tailwindcss", "vimls", "clangd", "marksman", "grammarly" }
			)
		end,
	},
	-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
	{
		"jay-babu/mason-null-ls.nvim",
		config = function(_, opts)
			local mason_null_ls = require("mason-null-ls")
			local null_ls = require("null-ls")
			-- Ensure that opts.ensure_installed exists and is a table.
			if not opts.ensure_installed then
				opts.ensure_installed = {}
			end
			-- Add to opts.ensure_installed using vim.list_extend.
			utils.list_insert_unique(opts.ensure_installed, { "stylua", "eslint_d" })
			-- run setup
			mason_null_ls.setup(opts)

			mason_null_ls.setup_handlers({ -- setup custom handlers
				-- For prettierd:
				prettierd = function()
					null_ls.register(null_ls.builtins.formatting.prettierd.with({
						condition = function(local_utils)
							return local_utils.root_has_file("package.json")
								or local_utils.root_has_file(".prettierrc")
								or local_utils.root_has_file(".prettierrc.json")
								or local_utils.root_has_file(".prettierrc.js")
						end,
					}))
				end,
				-- For eslint_d:
				eslint_d = function()
					null_ls.register(null_ls.builtins.diagnostics.eslint_d.with({
						condition = function(local_utils)
							return local_utils.root_has_file("package.json")
								or local_utils.root_has_file(".eslintrc.json")
								or local_utils.root_has_file(".eslintrc.js")
						end,
					}))
				end,
			})
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
