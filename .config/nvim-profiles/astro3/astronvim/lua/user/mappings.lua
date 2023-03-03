-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
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

		["<leader>T"] = {
			name = "󰔫 Trouble",
			r = { "<cmd>Trouble lsp_references<cr>", desc = "References" },
			f = { "<cmd>Trouble lsp_definitions<cr>", desc = "Definitions" },
			d = { "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnostics" },
			q = { "<cmd>Trouble quickfix<cr>", desc = "QuickFix" },
			l = { "<cmd>Trouble loclist<cr>", desc = "LocationList" },
			w = { "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
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
}
