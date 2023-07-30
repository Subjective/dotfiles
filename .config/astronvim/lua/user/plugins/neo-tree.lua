local utils = require "astronvim.utils"
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.commands = utils.extend_tbl(opts.commands, {
      -- allow set_root when bind_to_cwd is disabled
      set_cwd = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then vim.api.nvim_set_current_dir(node.path) end
        require("neo-tree.sources.filesystem.commands").set_root(state)
      end,
      set_root_to_home = function() vim.cmd.Neotree "~" end,
      trash = function(state)
        local inputs = require "neo-tree.ui.inputs"
        local path = state.tree:get_node().path
        local msg = "Are you sure you want to trash " .. path
        inputs.confirm(msg, function(confirmed)
          if not confirmed then return end

          vim.fn.system { "trash", vim.fn.fnameescape(path) }
          require("neo-tree.sources.manager").refresh(state.name)
        end)
      end,
      trash_visual = function(state, selected_nodes)
        local inputs = require "neo-tree.ui.inputs"
        local count = #selected_nodes
        local msg = "Are you sure you want to trash " .. count .. " files ?"
        inputs.confirm(msg, function(confirmed)
          if not confirmed then return end
          for _, node in ipairs(selected_nodes) do
            vim.fn.system { "trash", vim.fn.fnameescape(node.path) }
          end
          require("neo-tree.sources.manager").refresh(state.name)
        end)
      end,
      open_nofocus = function(state)
        local node = state.tree:get_node()
        if require("neo-tree.utils").is_expandable(node) then
          state.commands["toggle_node"](state)
        else
          state.commands["open"](state)
          vim.cmd.Neotree "reveal"
        end
      end,
      deactivate = function() vim.cmd.Neotree "close" end,
    })

    -- add new mappings to all windows
    opts.window.mappings = utils.extend_tbl(opts.window.mappings, {
      ["."] = "set_cwd",
      ["~"] = "set_root_to_home",
      T = "trash",
      Z = "expand_all_nodes",
      ["<tab>"] = "open_nofocus",
    })
    opts.filesystem.bind_to_cwd = false
    opts.default_component_configs.indent = { padding = 0, indent_size = 2 }
  end,
}
