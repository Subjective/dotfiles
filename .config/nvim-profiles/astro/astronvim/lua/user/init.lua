-- AstroNvim Configuration
-- AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "stable", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_reload = false, -- automatically reload and sync packer after a successful update
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
			loaded_matchit = nil, -- enable matchit
			autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
			cmp_enabled = true, -- enable completion at start
			autopairs_enabled = true, -- enable autopairs at start
			-- diagnostics_enabled = true, -- enable diagnostics at start
			-- status_diagnostics_enabled = true, -- enable diagnostics in statusline
			diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
			icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
			ui_notifications_enabled = true, -- disable notifications when toggling UI elements
			heirline_bufferline = false, -- enable new heirline based bufferline (requires :PackerSync after changing)
			neoscroll_enabled = true,
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

	-- Set dashboard header
	header = {
		"                                                    ",
		" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		"                                                    ",
	},
	--
	-- Default theme configuration
	default_theme = {
		-- Modify the color palette for the default theme
		colors = {
			fg = "#abb2bf",
			bg = "#1e222a",
		},
		highlights = function(hl) -- or a function that returns a new table of colors to set
			local C = require("default_theme.colors")

			hl.Normal = { fg = C.fg, bg = C.bg }

			-- New approach instead of diagnostic_style
			hl.DiagnosticError.italic = true
			hl.DiagnosticHint.italic = true
			hl.DiagnosticInfo.italic = true
			hl.DiagnosticWarn.italic = true

			return hl
		end,
		-- enable or disable highlighting for extra plugins
		plugins = {
			aerial = true,
			beacon = false,
			bufferline = true,
			cmp = true,
			dashboard = true,
			highlighturl = true,
			hop = false,
			indent_blankline = true,
			lightspeed = false,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = false,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = false,
			telescope = true,
			treesitter = true,
			vimwiki = false,
			["which-key"] = true,
		},
	},
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
				-- "sumneko_lua",
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

		-- override the mason server-registration function
		-- server_registration = function(server, opts)
		--   require("lspconfig")[server].setup(opts)
		-- end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
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
			["sumneko_lua"] = {
				settings = {
					Lua = {
						workspace = {
							-- These two libs give lots of useful vim symbols
							library = {
								vim.fn.expand("$VIMRUNTIME"),
								require("neodev.config").types(),
							},
							checkThirdParty = false,
							maxPreload = 5000,
							preloadFileSize = 10000,
						},
					},
				},
			},
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
			-- quick save
			-- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},
	-- Configure plugins
	plugins = {
		init = {
			-- You can disable default plugins as follows:
			-- ["goolord/alpha-nvim"] = { disable = true },
			["Darazaki/indent-o-matic"] = { disable = true },
			-- You can also add new plugins here as well:
			-- Add plugins, the packer syntax without the "use"
			-- { "andweeb/presence.nvim" },
			-- {
			--   "ray-x/lsp_signature.nvim",
			--   event = "BufRead",
			--   config = function()
			--     require("lsp_signature").setup()
			--   end,
			-- },

			-- We also support a key value style plugin definition similar to NvChad:
			-- ["ray-x/lsp_signature.nvim"] = {
			--   event = "BufRead",
			--   config = function()
			--     require("lsp_signature").setup()
			--   end,
			-- },
			-- [
			["folke/tokyonight.nvim"] = {},
			["kylechui/nvim-surround"] = {
				config = function()
					require("nvim-surround").setup({
						-- Configuration here, or leave empty to use defaults
						indent_lines = false,
					})
				end,
			},
			-- ["tpope/vim-surround"] = {},
			["karb94/neoscroll.nvim"] = {
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
			["ggandor/leap.nvim"] = {
				config = function()
					require("leap").add_default_mappings()
				end,
			},
			["folke/trouble.nvim"] = {
				requires = "nvim-tree/nvim-web-devicons",
				config = function()
					require("trouble").setup({})
				end,
			},
			["echasnovski/mini.map"] = {
				branch = "stable",
				config = function()
					require("mini.map")
				end,
			},
			["lewis6991/satellite.nvim"] = {
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
			["sindrets/diffview.nvim"] = {
				requires = "nvim-lua/plenary.nvim",
			},

			["folke/neodev.nvim"] = {
				config = function()
					require("neodev").setup({})
				end,
			},
		},
		-- All other entries override the require("<key>").setup({...}) call for default plugins
		["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
			-- config variable is the default configuration table for the setup function call
			-- local null_ls = require "null-ls"

			-- Check supported formatters and linters
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
			config.sources = {
				-- Set a formatter
				-- null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.prettier,
			}
			return config -- return final config table
		end,
		treesitter = { -- overrides `require("treesitter").setup(...)`
			ensure_installed = { "lua", "javascript" },
			indent = { enable = true, disable = { "lua", "python", "yaml" } },
		},
		-- use mason-lspconfig to configure LSP installations
		["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
			-- ensure_installed = { "sumneko_lua" },
		},
		-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
		["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
			-- ensure_installed = { "prettier", "stylua" },
		},
		["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
			-- ensure_installed = { "python" },
		},
	},
	-- LuaSnip Options
	luasnip = {
		-- Extend filetypes
		filetype_extend = {
			-- javascript = { "javascriptreact" },
		},
		-- Configure luasnip loaders (vscode, lua, and/or snipmate)
		vscode = {
			-- Add paths for including more VS Code style snippets in luasnip
			paths = {},
		},
	},
	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},
	-- Customize Heirline options
	heirline = {
		-- -- Customize different separators between sections
		-- separators = {
		--   tab = { "", "" },
		-- },
		-- -- Customize colors for each element each element has a `_fg` and a `_bg`
		-- colors = function(colors)
		--   colors.git_branch_fg = astronvim.get_hlgroup "Conditional"
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
			},
		},
	},
	-- Modify which-key registration (Use this with mappings table in the above.)
	["which-key"] = {
		-- Add bindings which show up as group name
		register = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- third key is the key to bring up next level and its displayed
					-- group name in which-key top level menu
					["b"] = { name = "Buffer" },
					["T"] = {
						name = "Trouble",
						r = { "<cmd>Trouble lsp_references<cr>", "References" },
						f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
						d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
						q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
						l = { "<cmd>Trouble loclist<cr>", "LocationList" },
						w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
					},
					["m"] = {
						function()
							local status, map = pcall(require, "mini.map")
							if not status then
								astronvim.notify("MiniMap not available")
							else
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

								map.toggle()
								if not Map_enabled then
									astronvim.notify("Minimap enabled")
								else
									astronvim.notify("Minimap disabled")
								end
								Map_enabled = not Map_enabled
							end
						end,
						"Toggle MiniMap",
					},
					["uh"] = {
						function()
							vim.cmd([[Gitsigns toggle_linehl]])
							if not Line_diff_hl_enabled then
								astronvim.notify("line diff highlight on")
							else
								astronvim.notify("line diff highlight off")
							end
							Line_diff_hl_enabled = not Line_diff_hl_enabled
						end,
						"Toggle line diff highlight",
					},
					["u"] = {
						e = {
							function()
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
									astronvim.notify("smooth scrolling off")
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

									astronvim.notify("smooth scrolling on")
								end
								vim.g.neoscroll_enabled = not vim.g.neoscroll_enabled
							end,
							"Toggle smooth scrolling",
						},
					},
				},
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
