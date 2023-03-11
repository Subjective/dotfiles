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
	{
		"karb94/neoscroll.nvim",
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
		"echasnovski/mini.map",
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
		"echasnovski/mini.animate",
		enabled = false,
		event = "VeryLazy",
		opts = function()
			-- don't use animate when scrolling with the mouse
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				cursor = {
					enable = false,
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
					path = animate.gen_path.line({
						predicate = function(destination)
							return destination[1] < -2 or 2 < destination[1]
						end,
					}),
				},
				resize = {
					enable = false,
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				scroll = {
					-- timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
					timing = function(_, n)
						return math.min(150 / n, 5)
					end,
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.animate").setup(opts)
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
				excluded_filetypes = {
					"prompt",
					"noice",
					"notify",
					"alpha",
					"qf",
					"minimap",
					"toggleterm",
					"TelescopePrompt",
				},
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
						signs = {
							-- can only be a single character (multibyte is okay)
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
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
	},
	{
		enabled = false,
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		},
		init = function()
			vim.g.lsp_handlers_enabled = false
		end,
	},
}
