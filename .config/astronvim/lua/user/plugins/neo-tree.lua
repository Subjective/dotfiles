local utils = require "astronvim.utils"

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.commands = utils.extend_tbl(opts.commands, {
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
      select_file = function(state)
        state.clipboard = state.clipboard or {}
        local function select_node(node)
          if node.type == "directory" then
            local children = state.tree:get_nodes(node:get_id())
            for _, child in ipairs(children) do
              select_node(child)
            end
          else
            local id = node:get_id()
            local data = state.clipboard[id]
            if data and data.action == "select" then
              state.clipboard[id] = nil
            else
              state.clipboard[id] = { action = "select", node = node }
            end
            require("neo-tree.ui.renderer").redraw(state)
          end
        end
        local node = state.tree:get_node()
        if node then
          require("neo-tree.sources.filesystem.commands").expand_all_nodes(state, node)
          vim.defer_fn(function() select_node(node) end, 100)
        end
      end,
      smart_open = function(state)
        local clipboard = state.clipboard or {}
        local node = state.tree:get_node()
        local selected = false
        for id, data in pairs(clipboard) do
          if data.action == "select" then
            selected = true
            require("neo-tree.utils").open_file(state, id)
            state.clipboard[id] = nil
          end
        end
        if selected then
          if node.type ~= "directory" then require("neo-tree.utils").open_file(state, node:get_id()) end
        else
          state.commands["open"](state)
        end
        require("neo-tree.ui.renderer").redraw(state)
      end,
      clear_clipboard = function(state)
        state.clipboard = {}
        require("neo-tree.ui.renderer").redraw(state)
      end,
    })

    -- add new mappings to all windows
    opts.window.mappings = utils.extend_tbl(opts.window.mappings, {
      ["~"] = "set_root_to_home",
      T = "trash",
      Z = "expand_all_nodes",
      ["<tab>"] = "select_file",
      ["<cr>"] = "smart_open",
      X = "clear_clipboard",
    })
    opts.window.mappings.o = nil -- TODO: remove in AstroNvim v4

    opts.filesystem.bind_to_cwd = false
    opts.default_component_configs.indent = { padding = 0, indent_size = 2 }
  end,
  keys = {
    {
      "<leader>e",
      function() require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() } end,
      desc = "Toggle Explorer (cwd)",
    },
    {
      "<leader>E",
      function() require("neo-tree.command").execute { toggle = true } end,
      desc = "Toggle Explorer (root)",
    },
  },
}
