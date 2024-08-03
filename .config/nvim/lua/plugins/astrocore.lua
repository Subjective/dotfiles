-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local utils = require "astrocore"

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Enable git integration for detached worktrees
    git_worktrees = { { toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/.cfg" } }, -- allow detached git_worktrees to be detected
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
      update_in_insert = false,
      signs = false,
    },
    -- HACK: Configure signs while disabling them for diagnostics
    signs = {
      DiagnosticSignError = { text = "", texthl = "DiagnosticSignError" },
      DiagnosticSignWarn = { text = "", texthl = "DiagnosticSignWarn" },
      DiagnosticSignInfo = { text = "", texthl = "DiagnosticSignInfo" },
      DiagnosticSignHint = { text = "󰌵", texthl = "DiagnosticSignHint" },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        spell = false,
        wrap = false,
        conceallevel = 2,
        clipboard = "",
        splitkeep = "screen",
        list = true, -- show whitespace characters
        listchars = { tab = "→\\", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
        spellfile = vim.fn.expand "~/.config/astronvim/lua/user/spell/en.utf-8.add",
        cmdheight = 1,
        thesaurus = vim.fn.expand "~/.config/astronvim/lua/user/spell/mthesaur.txt",
        shada = string.gsub(vim.opt.shada._value, "'(%d+)", "'" .. 500), -- increase default oldfiles history length to 500
        scrolloff = 8, -- number of lines to keep above and below the cursor
        sidescrolloff = 8, -- number of columns to keep at the sides of the cursor
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        -- ["<Leader>bD"] = {
        --   function()
        --     require("astroui.status.heirline").buffer_picker(
        --       function(bufnr) require("astrocore.buffer").close(bufnr) end
        --     )
        --   end,
        --   desc = "Pick to close",
        -- },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        -- disable quick save
        ["<C-s>"] = false,
        -- clear search highlights
        ["<ESC>"] = { "<cmd>nohlsearch<cr><cmd>echon ''<cr>", desc = "Clear search highlights" },
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
        -- toggle current line git blame
        ["<leader>gB"] = {
          function()
            local enabled = require("gitsigns").toggle_current_line_blame()
            utils.notify("Current line Git blame " .. (enabled and "enabled" or "disabled"))
          end,
          desc = "Toggle current line Git blame",
        },
        -- toggle indent guides
        ["<leader>u|"] = {
          function()
            vim.cmd "IBLToggle"
            vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
            if MiniIndentscope and not vim.g.miniindentscope_disable then
              MiniIndentscope.draw()
            else
              MiniIndentscope.undraw()
            end
            utils.notify("Indent guides " .. (vim.g.miniindentscope_disable and "disabled" or "enabled"))
          end,
          desc = "Toggle indent guides",
        },
        -- better buffer navigation
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["<leader>`"] = { function() require("astrocore.buffer").prev() end, desc = "Previous buffer" },
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
        -- rename session
        ["<leader>Sr"] = {
          function()
            local current_session_name = require("resession").get_current()
            if current_session_name then
              vim.ui.input({ prompt = string.format('Rename session "%s" to', current_session_name) }, function(name)
                if name then
                  require("resession").save(name)
                  require("resession").delete(current_session_name)
                end
              end)
            else
              utils.notify("No session available to rename", vim.log.levels.ERROR, { title = "" })
            end
          end,
          desc = "Rename this session",
        },
      },
      v = {},
      i = {
        -- spelling autocorrect binding
        ["<C-s>"] = { "<C-g>u<Esc>[s1z=`]a<C-g>u", desc = "autocorrect spelling error" },
        -- view lsp signature help
        ["<C-l>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
      },
      t = {
        -- ["<esc><esc>"] = { "<c-\\><c-n>", desc = "Enter Normal Mode" },
        ["<C-j>"] = {
          callback = function()
            if string.match(vim.api.nvim_buf_get_name(0), ":lazygit") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-j>", true, false, true), "n", false)
            else
              vim.cmd "wincmd j"
            end
          end,
        },
        ["<C-k>"] = {
          callback = function()
            if string.match(vim.api.nvim_buf_get_name(0), ":lazygit") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-k>", true, false, true), "n", false)
            else
              vim.cmd "wincmd k"
            end
          end,
        },
      },
      x = {
        -- yank to system clipboard
        ["<leader>y"] = { '"+y', desc = "Yank to clipboard" },
        -- TODO: Remove below mapping later
        -- don't replace yank buffer when pasting over selection
        ["<leader>p"] = { '"_dP', desc = "Blackhole paste" },
        -- better increment/decrement
        ["<C-->"] = { "g<C-a>", desc = "Increment number" },
        ["<C-=>"] = { "g<C-x>", desc = "Decrement number" },
      },
      o = {},
    },
  },
}
