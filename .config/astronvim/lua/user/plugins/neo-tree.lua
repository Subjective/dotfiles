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
  keys = function()
    local function get_root()
      local root_patterns = { ".git", "lua" }
      ---@type string?
      local path = vim.api.nvim_buf_get_name(0)
      path = path ~= "" and vim.uv.fs_realpath(path) or nil
      ---@type string[]
      local roots = {}
      if path then
        for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
          local workspace = client.config.workspace_folders
          local paths = workspace and vim.tbl_map(function(ws) return vim.uri_to_fname(ws.uri) end, workspace)
            or client.config.root_dir and { client.config.root_dir }
            or {}
          for _, p in ipairs(paths) do
            local r = vim.uv.fs_realpath(p)
            if path:find(r, 1, true) then roots[#roots + 1] = r end
          end
        end
      end
      table.sort(roots, function(a, b) return #a > #b end)
      ---@type string?
      local root = roots[1]
      if not root then
        path = path and vim.fs.dirname(path) or vim.uv.cwd()
        ---@type string?
        root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.uv.cwd()
      end
      ---@cast root string
      return root
    end

    return {
      {
        "<leader>e",
        function() require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() } end,
        desc = "Toggle Explorer (cwd)",
      },
      {
        "<leader>E",
        function() require("neo-tree.command").execute { toggle = true, dir = get_root() } end,
        desc = "Toggle Explorer (root)",
      },
    }
  end,
}
