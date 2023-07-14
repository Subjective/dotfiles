-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require "astronvim.utils"

return {
  n = {
    -- disable quick save
    ["<C-s>"] = false,
    -- clear search highlights
    ["<ESC>"] = { "<cmd>nohlsearch<cr><cmd>redrawstatus<cr>", desc = "Clear search highlights" },
    -- yank to system clipboard
    ["<leader>y"] = { '"+y', desc = "Yank to clipboard" },
    ["<leader>Y"] = { '"+y$', desc = "which_key_ignore" },
    ['y"'] = { function() vim.fn.setreg("+", vim.fn.getreg '"') end, desc = "Copy last yank to clipboard" },
    -- better increment/decrement
    ["<C-->"] = { "<c-x>", desc = "Decrement number" },
    ["<C-=>"] = { "<c-a>", desc = "Increment number" },
    -- toggle-term dotfiles
    ["<leader>g."] = {
      function() utils.toggle_term_cmd "lazygit --git-dir=$HOME/.cfg --work-tree=$HOME" end,
      desc = "ToggleTerm lazygit dotfiles",
    },
    -- explorer bindings
    ["<leader>o"] = false,
    ["<leader>E"] = {
      function()
        local function get_root()
          local root_patterns = { ".git", "lua" }
          ---@type string?
          local path = vim.api.nvim_buf_get_name(0)
          path = path ~= "" and vim.uv.fs_realpath(path) or nil
          ---@type string[]
          local roots = {}
          if path then
            for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
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
        require("neo-tree.command").execute { toggle = true, dir = get_root() }
      end,
      desc = "Toggle Explorer (root)",
    },
    ["<leader>e"] = {
      function() require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() } end,
      desc = "Toggle Explorer (cwd)",
    },
    -- hide winbar in local buffer
    ["<leader>uW"] = {
      function() vim.wo.winbar = nil end,
      desc = "Hide winbar (buffer)",
    },
    ["<leader>uI"] = {
      function()
        vim.g.indent_blankline_enabled = not vim.g.indent_blankline_enabled
        vim.cmd "IndentBlanklineRefresh"
        vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
        if vim.g.miniindentscope_disable then
          MiniIndentscope.undraw()
        else
          MiniIndentscope.draw()
        end
        utils.notify("Indentation guides " .. (vim.g.indent_blankline_enabled and "enabled" or "disabled"))
      end,
      desc = "Toggle indentation guides (buffer)",
    },
    -- better buffer navigation
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>`"] = { "<cmd>e #<cr>", desc = "Previous buffer" },
    -- disable default bindings
    ["<C-Down>"] = false,
    ["<C-Left>"] = false,
    ["<C-Right>"] = false,
    ["<C-Up>"] = false,
    -- Resize with arrows
    ["<Up>"] = {
      function() require("smart-splits").resize_up() end,
      desc = "Resize split up",
    },
    ["<Down>"] = {
      function() require("smart-splits").resize_down() end,
      desc = "Resize split down",
    },
    ["<Left>"] = {
      function() require("smart-splits").resize_left() end,
      desc = "Resize split left",
    },
    ["<Right>"] = {
      function() require("smart-splits").resize_right() end,
      desc = "Resize split right",
    },
    -- fix substution command conflict with Noice
    ["&"] = { "&", silent = true, desc = "Repeat last substiution" },
  },
  v = {},
  i = {
    -- spelling autocorrect binding
    ["<C-s>"] = { "<C-g>u<Esc>[s1z=`]a<C-g>u", desc = "autocorrect spelling error" },
    -- view lsp signature help
    ["<C-l>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  x = {
    -- yank to system clipboard
    ["<leader>y"] = { '"+y', desc = "Yank to clipboard" },
    -- don't replace yank buffer when pasting over selection
    ["<leader>p"] = { '"_dP', desc = "Blackhole paste" },
    -- move lines up and down
    J = { ":m '>+1<CR>gv=gv", silent = true },
    K = { ":m '<-2<CR>gv=gv", silent = true },
    -- better increment/decrement
    ["<C-->"] = { "g<C-a>", desc = "Increment number" },
    ["<C-=>"] = { "g<C-x>", desc = "Decrement number" },
  },
  o = {},
}
