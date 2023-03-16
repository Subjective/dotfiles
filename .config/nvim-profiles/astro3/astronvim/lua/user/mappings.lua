-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local astro_utils = require("astronvim.utils")

return {
	-- first key is the mode
	n = {
		-- second key is the lefthand side of the map
		-- tables with the `name` key will be registered with which-key if it's installed
		-- this is useful for naming menus
				["<leader>b"] = { name = "Buffers" },
		-- disable quick save
				["<C-s>"] = false,
		-- better increment/decrement
				["-"] = { "<c-x>", desc = "Descrement number" },
				["+"] = { "<c-a>", desc = "Increment number" },
				["<leader>g."] = {
			function()
				if vim.g.dotfiles_diff_enabled then
					vim.env.GIT_WORK_TREE = nil
					vim.env.GIT_DIR = nil
					astro_utils.notify("dotfiles diff disabled")
					require("gitsigns").refresh()
				else
					vim.env.GIT_WORK_TREE = vim.fn.expand("~")
					vim.env.GIT_DIR = vim.fn.expand("~/.cfg")
					astro_utils.notify("dotfiles diff enabled")
				end
				vim.g.dotfiles_diff_enabled = not vim.g.dotfiles_diff_enabled
				-- reload buffer
				vim.cmd([[silent! bufdo e]])
			end,
			desc = "Toggle dotfiles diff",
		},
				["<leader>gD"] = {
			function()
				vim.cmd([[DiffviewOpen]])
			end,
			desc = "Open Diffview",
		},
				["<leader>E"] = {
			function()
				local function get_root()
					local root_patterns = { ".git", "lua" }
					---@type string?
					local path = vim.api.nvim_buf_get_name(0)
					path = path ~= "" and vim.loop.fs_realpath(path) or nil
					---@type string[]
					local roots = {}
					if path then
						for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
							local workspace = client.config.workspace_folders
							local paths = workspace
									and vim.tbl_map(function(ws)
										return vim.uri_to_fname(ws.uri)
									end, workspace)
									or client.config.root_dir and { client.config.root_dir }
									or {}
							for _, p in ipairs(paths) do
								local r = vim.loop.fs_realpath(p)
								if path:find(r, 1, true) then
									roots[#roots + 1] = r
								end
							end
						end
					end
					table.sort(roots, function(a, b)
						return #a > #b
					end)
					---@type string?
					local root = roots[1]
					if not root then
						path = path and vim.fs.dirname(path) or vim.loop.cwd()
						---@type string?
						root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
						root = root and vim.fs.dirname(root) or vim.loop.cwd()
					end
					---@cast root string
					return root
				end
				require("neo-tree.command").execute({ toggle = true, dir = get_root() })
			end,
			desc = "Toggle Explorer (root)",
		},
				["<leader>e"] = {
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Toggle Explorer (cwd)",
		},
				["<leader>T"] = { name = "󰔫 Trouble" },
				["<leader>Tr"] = { "<cmd>Trouble lsp_references<cr>", desc = "References" },
				["<leader>Tf"] = { "<cmd>Trouble lsp_definitions<cr>", desc = "Definitions" },
				["<leader>Td"] = { "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnostics" },
				["<leader>Tq"] = { "<cmd>Trouble quickfix<cr>", desc = "QuickFix" },
				["<leader>Tl"] = { "<cmd>Trouble loclist<cr>", desc = "LocationList" },
				["<leader>Tw"] = { "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
		-- better buffer navigation
				["]b"] = false,
				["[b"] = false,
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
				["<C-Down>"] = false,
				["<C-Left>"] = false,
				["<C-Right>"] = false,
				["<C-Up>"] = false,
		-- Resize with arrows
				["<Up>"] = {
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize split up",
		},
				["<Down>"] = {
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize split down",
		},
				["<Left>"] = {
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize split left",
		},
				["<Right>"] = {
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize split right",
		},
	},
	i = {
				["<C-s>"] = { "<C-g>u<Esc>[s1z=`]a<C-g>u", desc = "autocorrect spelling error" },
	},
	t = {
		-- setting a mapping to false will disable it
		-- ["<esc>"] = false,
	},
	x = {
		-- better increment/decrement
				["+"] = { "g<C-a>", desc = "Increment number" },
				["-"] = { "g<C-x>", desc = "Descrement number" },
	},
}
