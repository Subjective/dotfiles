return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = function(_, opts)
		-- define new global commands
		local global_commands = {
			-- allow set_root when bind_to_cwd is disabled
			set_cwd = function(state)
				local path = state.tree:get_node().path
				vim.api.nvim_set_current_dir(path)
				vim.cmd(string.format("Neotree %s", path))
			end,
			set_root_to_home = function()
				vim.cmd("Neotree ~")
			end,
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
		opts.window.mappings["."] = "set_cwd"
		opts.window.mappings["@"] = "set_root_to_home"
		opts.filesystem.bind_to_cwd = false

		-- return new opts
		return opts
	end,
}