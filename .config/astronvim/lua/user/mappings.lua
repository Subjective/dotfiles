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
    -- toggle winbar
    ["<leader>uW"] = {
      function()
        if vim.g.winbar_disabled then
          vim.wo.winbar = vim.g.prev_winbar
          vim.api.nvim_clear_autocmds { group = "disable_winbar" }
        else
          vim.g.prev_winbar = vim.wo.winbar
          vim.wo.winbar = nil
          vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter", "BufNew" }, {
            pattern = "*",
            callback = function() vim.wo.winbar = nil end,
            group = vim.api.nvim_create_augroup("disable_winbar", { clear = true }),
            desc = "Toggle winbar",
          })
        end
        utils.notify("winbar " .. (vim.g.winbar_disabled and "enabled" or "disabled"))
        vim.g.winbar_disabled = not vim.g.winbar_disabled
      end,
      desc = "Toggle winbar",
    },
    -- toggle current line git blame
    ["<leader>gB"] = {
      function()
        local enabled = require("gitsigns").toggle_current_line_blame()
        utils.notify("Current line Git blame " .. (enabled and "enabled" or "disabled"))
      end,
      desc = "Toggle current line Git blame",
    },
    -- toggle indentation guides
    ["<leader>uI"] = {
      function()
        vim.g.indent_blankline_enabled = not vim.g.indent_blankline_enabled
        vim.cmd "IndentBlanklineRefresh"
        vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
        if MiniIndentscope and not vim.g.miniindentscope_disable then
          MiniIndentscope.draw()
        else
          MiniIndentscope.undraw()
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
    J = { ":m '>+1<CR>gv=gv", desc = "Move line down", silent = true },
    K = { ":m '<-2<CR>gv=gv", desc = "Move line up", silent = true },
    -- better increment/decrement
    ["<C-->"] = { "g<C-a>", desc = "Increment number" },
    ["<C-=>"] = { "g<C-x>", desc = "Decrement number" },
  },
  o = {},
}
