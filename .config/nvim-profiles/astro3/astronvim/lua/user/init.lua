--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- A split up user configuration example can be found at: https://github.com/AstroNvim/split_user_example

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "nightly", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "v3", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_quit = false, -- automatically quit the current session after a successful update
		-- remotes = { -- easily add new remotes to track
		--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
		--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},
	-- Set colorscheme to use
	colorscheme = "tokyonight-night",
	-- Add highlight groups in any theme
	highlights = {
		-- init = { -- this table overrides highlights in all themes
		--   Normal = { bg = "#000000" },
		-- }
		-- duskfox = { -- a table of overrides/changes to the duskfox theme
		--   Normal = { bg = "#000000" },
		-- },
	},
	-- set vim options here (vim.<first_key>.<second_key> = value)
	options = {
		opt = {
			-- set to true or false etc.
			relativenumber = true, -- sets vim.opt.relativenumber
			number = true, -- sets vim.opt.number
			spell = false, -- sets vim.opt.spell
			signcolumn = "auto", -- sets vim.opt.signcolumn to auto
			wrap = false, -- sets vim.opt.wrap
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
			cmp_enabled = true, -- enable completion at start
			autopairs_enabled = true, -- enable autopairs at start
			diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
			icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
			ui_notifications_enabled = true, -- disable notifications when toggling UI elements
			neoscroll_enabled = true,
			minimap_enabled = false,
		},
	},
	-- If you need more control, you can use the function()...end notation
	-- options = function(local_vim)
	--   local_vim.opt.relativenumber = true
	--   local_vim.g.mapleader = " "
	--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
	--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
	--
	--   return local_vim
	-- end,

	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		underline = true,
	},
	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without mason
		servers = {
			-- "pyright"
		},
		formatting = {
			-- control auto formatting on save
			format_on_save = {
				enabled = true, -- enable or disable format on save globally
				allow_filetypes = { -- enable format on save for specified filetypes only
					-- "go",
				},
				ignore_filetypes = { -- disable format on save for specified filetypes
					-- "python",
				},
			},
			disabled = { -- disable formatting capabilities for the listed language servers
				-- "lua_ls",
			},
			timeout_ms = 1000, -- default format timeout
			-- filter = function(client) -- fully override the default formatting function
			--   return true
			-- end
		},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		-- add to the global LSP on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the LSP setup handler function based on server name
		-- setup_handlers = {
		--   -- first function changes the default setup handler
		--   function(server, opts) require("lspconfig")[server].setup(opts) end,
		--   -- keys for a specific server name will be used for that LSP
		--   lua_ls = function(server, opts)
		--     -- custom lua_ls setup handler
		--     require("lspconfig")["lua_ls"].setup(opts)
		--   end,
		-- },

		-- Add overrides for LSP server settings, the keys are the name of the server
		config = {
			-- example for addings schemas to yamlls
			-- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },
			-- lua_ls = {
			-- 	settings = {
			-- 		Lua = {
			-- 			workspace = {
			-- 				library = {
			-- 					vim.fn.expand("$VIMRUNTIME"),
			-- 					require("neodev.config").types(),
			-- 				},
			-- 				checkThirdParty = false,
			-- 				maxPreload = 5000,
			-- 				preloadFileSize = 10000,
			-- 			},
			-- 		},
			-- 	},
			-- },
		},
	},
	-- Mapping data with "desc" stored directly by vim.keymap.set().
	--
	-- Please use this mappings table to set keyboard mapping since this is the
	-- lower level configuration and more robust one. (which-key will
	-- automatically pick-up stored data by this setting.)
	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			-- mappings seen under group name "Buffer"
			["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
			["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
			["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
			["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
			-- tables with the `name` key will be registered with which-key if it's installed
			-- this is useful for naming menus
			["<leader>b"] = { name = "Buffers" },
			-- quick save
			-- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
			["<leader>ue"] = {
				function()
					local utils = require("astronvim.utils")
					if vim.g.neoscroll_enabled then
						vim.cmd("unmap <C-u>")
						vim.cmd("unmap <C-d>")
						vim.cmd("unmap <C-b>")
						vim.cmd("unmap <C-f>")
						vim.cmd("unmap <C-y>")
						vim.cmd("unmap <C-e>")
						vim.cmd("unmap zt")
						vim.cmd("unmap zz")
						vim.cmd("unmap zb")
						utils.notify("smooth scrolling off")
					else
						local t = {}
						t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
						t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
						t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
						t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
						t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
						t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
						t["zt"] = { "zt", { "250" } }
						t["zz"] = { "zz", { "250" } }
						t["zb"] = { "zb", { "250" } }
						require("neoscroll.config").set_mappings(t)

						utils.notify("smooth scrolling on")
					end
					vim.g.neoscroll_enabled = not vim.g.neoscroll_enabled
				end,
				desc = "Toggle smooth scrolling",
			},

			["<leader>m"] = {
				function()
					local utils = require("astronvim.utils")
					local status, map = pcall(require, "mini.map")
					if not status then
						utils.notify("MiniMap not available")
					else
						map.toggle()
						if not vim.g.minimap_enabled then
							vim.cmd([[SatelliteDisable]])
							utils.notify("Minimap enabled")
						else
							vim.cmd([[SatelliteEnable]])
							utils.notify("Minimap disabled")
						end
						vim.g.minimap_enabled = not vim.g.minimap_enabled
					end
				end,
				desc = "Toggle MiniMap",
			},

			L = {
				function()
					require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
				end,
				desc = "Next buffer",
			},
			H = {
				function()
					require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
				end,
				desc = "Previous buffer",
			},

			-- Resize with arrows
			["<C-S-Up>"] = {
				function()
					require("smart-splits").resize_up()
				end,
				desc = "Resize split up",
			},
			["<C-S-Down>"] = {
				function()
					require("smart-splits").resize_down()
				end,
				desc = "Resize split down",
			},
			["<C-S-Left>"] = {
				function()
					require("smart-splits").resize_left()
				end,
				desc = "Resize split left",
			},
			["<C-S-Right>"] = {
				function()
					require("smart-splits").resize_right()
				end,
				desc = "Resize split right",
			},
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},
	-- Configure require("lazy").setup() options
	lazy = {
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
	},
	-- Configure plugins
	plugins = {
		-- You can disable default plugins as follows:
		-- { "max397574/better-escape.nvim", enabled = false },
		--
		-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
		-- {
		--   "L3MON4D3/LuaSnip",
		--   config = function(plugin, opts)
		--     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
		--     -- add more custom luasnip configuration such as filetype extend or custom snippets
		--     local luasnip = require "luasnip"
		--     luasnip.filetype_extend("javascript", { "javascriptreact" })
		--   end,
		-- },

		-- TODO Split-up configuration and move neo-tree config to dedicated plugins directory
		{
			"nvim-neo-tree/neo-tree.nvim",
			opts = function(_, opts)
				-- define new global commands
				local global_commands = {
					trash = function(state)
						local inputs = require("neo-tree.ui.inputs")
						local path = state.tree:get_node().path
						local msg = "Are you sure you want to trash " .. path
						inputs.confirm(msg, function(confirmed)
							if not confirmed then
								return
							end

							vim.fn.system({ "trash", vim.fn.fnameescape(path) })
							require("neo-tree.sources.manager").refresh(state.name)
						end)
					end,
					trash_visual = function(state, selected_nodes)
						local inputs = require("neo-tree.ui.inputs")

						function GetTableLen(tbl)
							local len = 0
							for _ in pairs(tbl) do
								len = len + 1
							end
							return len
						end

						local count = GetTableLen(selected_nodes)
						local msg = "Are you sure you want to trash " .. count .. " files ?"
						inputs.confirm(msg, function(confirmed)
							if not confirmed then
								return
							end
							for _, node in ipairs(selected_nodes) do
								vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
							end
							require("neo-tree.sources.manager").refresh(state.name)
						end)
					end,
				}

				-- apply global commands to each section
				for _, type in ipairs({ "filesystem", "buffers", "git_status", "diagnostics" }) do
					opts[type].commands = require("astronvim.utils").extend_tbl(opts[type].commands, global_commands)
				end

				-- add new mappings to all windows
				opts.window.mappings.T = "trash"

				-- return new opts
				return opts
			end,
		},
		-- {
		--   "windwp/nvim-autopairs",
		--   config = function(plugin, opts)
		--     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
		--     -- add more custom autopairs configuration such as custom rules
		--     local npairs = require "nvim-autopairs"
		--     local Rule = require "nvim-autopairs.rule"
		--     local cond = require "nvim-autopairs.conds"
		--     npairs.add_rules(
		--       {
		--         Rule("$", "$", { "tex", "latex" })
		--           -- don't add a pair if the next character is %
		--           :with_pair(cond.not_after_regex "%%")
		--           -- don't add a pair if  the previous character is xxx
		--           :with_pair(
		--             cond.not_before_regex("xxx", 3)
		--           )
		--           -- don't move right when repeat character
		--           :with_move(cond.none())
		--           -- don't delete if the next character is xx
		--           :with_del(cond.not_after_regex "xx")
		--           -- disable adding a newline when you press <cr>
		--           :with_cr(cond.none()),
		--       },
		--       -- disable for .vim files, but it work for another filetypes
		--       Rule("a", "a", "-vim")
		--     )
		--   end,
		-- },

		-- By adding to the which-key config and using our helper function you can add more which-key registered bindings
		-- {
		--   "folke/which-key.nvim",
		--   config = function(plugin, opts)
		--     require "plugins.configs.which-key"(plugin, opts)
		--     -- Add bindings which show up as group name
		--     local wk = require "which-key"
		--     wk.register({
		--       b = { name = "Buffer" },
		--     }, { mode = "n", prefix = "<leader>" })
		--   end,
		-- },

		-- You can also add new plugins here as well:
		-- Add plugins, the lazy syntax
		-- "andweeb/presence.nvim",
		-- {
		--   "ray-x/lsp_signature.nvim",
		--   event = "BufRead",
		--   config = function()
		--     require("lsp_signature").setup()
		--   end,
		-- },
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
		},
		-- {
		-- 	"folke/todo-comments.nvim",
		-- 	cmd = { "TodoTrouble", "TodoTelescope" },
		-- 	event = { "BufReadPost", "BufNewFile" },
		-- 	config = true,
		-- 	-- stylua: ignore
		-- 	keys = {
		-- 		{ "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
		-- 		{ "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
		-- 		{ "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
		-- 		{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
		-- 		{ "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
		-- 	},
		-- },
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
			"karb94/neoscroll.nvim",
			lazy = false,
			config = function()
				local neoscroll = require("neoscroll")
				if vim.g.neoscroll_enabled then
					neoscroll.setup()
				else
					neoscroll.setup({
						mappings = {},
					})
				end
			end,
		},
		{
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
		},
		{
			"folke/trouble.nvim",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		},
		{
			"echasnovski/mini.map",
			lazy = false,
			branch = "stable",
			config = function()
				local map = require("mini.map")
				map.setup({
					integrations = {
						map.gen_integration.builtin_search(),
						map.gen_integration.diagnostic({
							error = "DiagnosticFloatingError",
							warn = "DiagnosticFloatingWarn",
							info = "DiagnosticFloatingInfo",
							hint = "DiagnosticFloatingHint",
						}),
						map.gen_integration.gitsigns({
							add = "GitSignsAdd",
							change = "GitSignsChange",
							delete = "GitSignsDelete",
						}),
					},
					symbols = {
						encode = map.gen_encode_symbols.dot("4x2"),
					},
					window = {
						side = "right",
						width = 20, -- set to 1 for a pure scrollbar :)
						winblend = 15,
						show_integration_count = false,
					},
				})
			end,
		},
		{
			"lewis6991/satellite.nvim",
			lazy = false,
			config = function()
				require("satellite").setup({
					current_only = false,
					winblend = 50,
					zindex = 40,
					excluded_filetypes = { "alpha", "qf", "minimap", "toggleterm", "TelescopePrompt" },
					width = 2,
					handlers = {
						search = {
							enable = true,
						},
						diagnostic = {
							enable = true,
						},
						gitsigns = {
							enable = true,
							signs = { -- can only be a single character (multibyte is okay)
								add = "│",
								change = "│",
								delete = "-",
							},
						},
						marks = {
							enable = true,
							show_builtins = false, -- shows the builtin marks like [ ] < >
						},
					},
				})
			end,
		},
		{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
		-- {
		--   "folke/neodev.nvim",
		--   lazy = false,
		--   config = function()
		--     require("neodev").setup({})
		--   end,
		-- },
		-- Plugin entries can also be used to override the default options for plugins as well
		{
			"goolord/alpha-nvim",
			opts = function(_, opts)
				-- customize the dashboard header
				opts.section.header.val = {
					"                                                    ",
					" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
					" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
					" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
					" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
					" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
					" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
					"                                                    ",
				}
				return opts
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			opts = function(_, config)
				-- config variable is the default configuration table for the setup function call
				local null_ls = require("null-ls")

				-- Check supported formatters and linters
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
				config.sources = {
					-- Set a formatter
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
				}
				return config -- return final config table
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"lua",
					"javascript",
					"typescript",
					"swift",
					"html",
					"css",
					"cpp",
					"python",
					"java",
				},
			},
		},
		-- use mason-lspconfig to configure LSP installations
		{
			"williamboman/mason-lspconfig.nvim",
			-- overrides `require("mason-lspconfig").setup(...)`
			opts = {
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"tailwindcss",
					"vimls",
				},
			},
		},
		-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
		{
			"jay-babu/mason-null-ls.nvim",
			-- overrides `require("mason-null-ls").setup(...)`
			opts = {
				ensure_installed = { "prettier", "stylua" },
			},
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			-- overrides `require("mason-nvim-dap").setup(...)`
			opts = {
				ensure_installed = { "python" },
			},
		},
	},
	-- Customize Heirline options
	heirline = {
		-- -- Customize different separators between sections
		-- separators = {
		--   breadcrumbs = " > ",
		--   tab = { "", "" },
		-- },
		-- -- Customize colors for each element each element has a `_fg` and a `_bg`
		-- colors = function(colors)
		--   colors.git_branch_fg = require("astronvim.utils").get_hlgroup "Conditional"
		--   return colors
		-- end,
		-- -- Customize attributes of highlighting in Heirline components
		-- attributes = {
		--   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
		--   git_branch = { bold = true }, -- bold the git branch statusline component
		-- },
		-- -- Customize if icons should be highlighted
		icon_highlights = {
			breadcrumbs = true, -- LSP symbols in the breadcrumbs
			file_icon = {
				winbar = false, -- Filetype icon in the winbar inactive windows
				statusline = true, -- Filetype icon in the statusline
				tabline = true, -- Filetype icon in the tabline
			},
		},
	},
	-- This function is run last and is a good place to configuring
	-- augroups/autocommands and custom filetypes also this just pure lua so
	-- anything that doesn't fit in the normal config locations above can go here
	polish = function()
		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }
		--     { "BufEnter", "Filetype" },

		-- Don't auto comment new lines
		vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "*" }, command = "setlocal fo-=c fo-=r fo-=o" })
	end,
}

return config
