-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local astro_utils = require "astronvim.utils"

local function ui_notify(str)
  if vim.g.ui_notifications_enabled then astro_utils.notify(str) end
end

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- disable quick save
    ["<C-s>"] = false,
    ["<ESC>"] = { "<cmd>nohlsearch<cr><cmd>redrawstatus<cr>", desc = "Clear search highlights" },
    -- move cursor 1 line down, on the first non-blank character
    ["="] = { "+" },
    -- better increment/decrement
    ["<C-->"] = { "<c-x>", desc = "Decrement number" },
    ["<C-=>"] = { "<c-a>", desc = "Increment number" },
    -- smart toggle-term bindings
    ["<leader>g."] = {
      function() astro_utils.toggle_term_cmd "lazygit --git-dir=$HOME/.cfg --work-tree=$HOME" end,
      desc = "ToggleTerm lazygit dotfiles",
    },
    ["<leader>gg"] = {
      function()
        local git_dir = vim.env.GIT_DIR
        local git_work_tree = vim.env.GIT_WORK_TREE
        if git_dir and git_work_tree then
          astro_utils.toggle_term_cmd("lazygit --git-dir=" .. git_dir .. " --work-tree=" .. git_work_tree)
        else
          astro_utils.toggle_term_cmd "lazygit"
        end
      end,
      desc = "ToggleTerm lazygit",
    },
    ["<leader>tl"] = {
      function()
        local git_dir = vim.env.GIT_DIR
        local git_work_tree = vim.env.GIT_WORK_TREE
        if git_dir and git_work_tree then
          astro_utils.toggle_term_cmd("lazygit --git-dir=" .. git_dir .. " --work-tree=" .. git_work_tree)
        else
          astro_utils.toggle_term_cmd "lazygit"
        end
      end,
      desc = "ToggleTerm lazygit",
    },
    -- explorer bindings
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
    -- toggle undo tree
    ["<leader>U"] = {
      "<cmd>UndotreeToggle<cr>",
      desc = "Toggle Undo Tree",
    },
    -- hide winbar in local buffer
    ["<leader>uW"] = {
      function() vim.opt_local.winbar = nil end,
      desc = "Hide winbar (local)",
    },
    ["<leader>uI"] = {
      function()
        vim.cmd [[IndentBlanklineToggle]]
        ui_notify("Indentation guides " .. (vim.b.indentation_guides and "enabled" or "disabled") .. " (buffer)")
        vim.b.indentation_guides = not vim.b.indentation_guides
      end,
      desc = "Toggle indentation guides (buffer)",
    },
    ["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    -- trouble plugin mappings
    ["<leader>T"] = { name = "󰔫 Trouble" },
    ["<leader>Tr"] = { "<cmd>Trouble lsp_references<cr>", desc = "References" },
    ["<leader>Tf"] = { "<cmd>Trouble lsp_definitions<cr>", desc = "Definitions" },
    ["<leader>Td"] = { "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnostics" },
    ["<leader>Tq"] = { "<cmd>Trouble quickfix<cr>", desc = "QuickFix" },
    ["<leader>Tl"] = { "<cmd>Trouble loclist<cr>", desc = "LocationList" },
    ["<leader>Tw"] = { "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    ["<leader>Tt"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs" },
    -- Codeium
    ["<leader>;"] = { name = "󰧑 AI Assistant" },
    ["<leader>;;"] = {
      function()
        vim.cmd.Codeium(vim.g.codeium_enabled == 0 and "Enable" or "Disable")
        astro_utils.notify("Codeium " .. (vim.g.codeium_enabled == 0 and "Disabled" or "Enabled"))
      end,
      desc = "Toggle Codeium (global)",
    },
    ["<leader>;b"] = {
      function()
        vim.cmd.Codeium(vim.b.codeium_enabled == 0 and "EnableBuffer" or "DisableBuffer")
        astro_utils.notify("Codeium (buffer) " .. (vim.b.codeium_enabled == 0 and "Disabled" or "Enabled"))
      end,
      desc = "Toggle Codeium (buffer)",
    },
    -- ChatGPT
    ["<leader>;c"] = { "<cmd>ChatGPT<cr>" },
    ["<leader>;a"] = { "<cmd>ChatGPTActAs<cr>" },
    ["<leader>;e"] = { "<cmd>ChatGPTEditWithInstructions<cr>" },
    ["<leader>;r"] = { name = "ChatGPTRun" },
    ["<leader>;rg"] = { "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction" },
    ["<leader>;rT"] = { "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
    ["<leader>;rk"] = { "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
    ["<leader>;rd"] = { "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
    ["<leader>;rt"] = { "<cmd>ChatGPTRun add_test<cr>", desc = "Add Tests" },
    ["<leader>;ro"] = { "<cmd>ChatGPTRun optimize code<cr>", desc = "Optimize Code" },
    ["<leader>;rs"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
    ["<leader>;rf"] = { "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs" },
    ["<leader>;re"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain" },
    ["<leader>;rr"] = { "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Code Readability Analysis" },
    ["<leader>;rR"] = { "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen Edit" },
    -- Easy-Align
    ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
    -- better buffer navigation
    ["]b"] = false,
    ["[b"] = false,
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- neogen
    ["<leader>a"] = { desc = "󰏫 Annotate" },
    ["<leader>a<cr>"] = {
      function() require("neogen").generate { type = "current" } end,
      desc = "Current",
    },
    ["<leader>ac"] = {
      function() require("neogen").generate { type = "class" } end,
      desc = "Class",
    },
    ["<leader>af"] = {
      function() require("neogen").generate { type = "func" } end,
      desc = "Function",
    },
    ["<leader>at"] = {
      function() require("neogen").generate { type = "type" } end,
      desc = "Type",
    },
    ["<leader>aF"] = {
      function() require("neogen").generate { type = "file" } end,
      desc = "File",
    },
    -- telescope mappings
    ["<leader>fe"] = { "<cmd>Telescope file_browser<cr>", desc = "File explorer" },
    ["<leader>fp"] = {
      function() require("telescope").extensions.projects.projects {} end,
      desc = "Find projects",
    },
    ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    ["<leader>fu"] = { "<cmd>Telescope undo<cr>", desc = "Find in undo history" },
    -- octo plugin mappings
    ["<leader>G"] = { name = " GitHub" },
    ["<leader>Gs"] = { "<cmd>Octo search<cr>", desc = "Search GitHub" },
    ["<leader>Gi"] = { "<cmd>Octo issue list<cr>", desc = "Open Issues" },
    ["<leader>GI"] = { "<cmd>Octo issue search<cr>", desc = "Search Issues" },
    ["<leader>Gp"] = { "<cmd>Octo pr list<cr>", desc = "Open PRs" },
    ["<leader>GP"] = { "<cmd>Octo pr search<cr>", desc = "Search PRs" },
    ["<leader>Gr"] = { "<cmd>Octo repo list<cr>", desc = "Open Repository" },
    -- spectre mappings
    ["<leader>s"] = { desc = "󰛔 Search/Replace" },
    ["<leader>ss"] = {
      function() require("spectre").open() end,
      desc = "Spectre",
    },
    ["<leader>sf"] = {
      function() require("spectre").open_file_search() end,
      desc = "Spectre (current file)",
    },
    ["<leader>sw"] = {
      function() require("spectre").open_visual { select_word = true } end,
      desc = "Spectre (current word)",
    },
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
  },
  v = {
    ["<leader>s"] = {
      function() require("spectre").open_visual() end,
      desc = "Spectre",
    },
    -- move lines up and down
    J = { ":m '>+1<CR>gv=gv", desc = "move line down" },
    K = { ":m '<-2<CR>gv=gv", desc = "move line up" },
    -- don't replace yank buffer when pasting over selection
    ["<leader>p"] = { '"_dP', desc = "Blackhole paste" },
  },
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
    -- better increment/decrement
    ["<C-->"] = { "g<C-a>", desc = "Increment number" },
    ["<C-=>"] = { "g<C-x>", desc = "Decrement number" },
    -- line text-objects
    ["il"] = { "g_o^", desc = "Inside line text object" },
    ["al"] = { "$o^", desc = "Around line text object" },
    -- Easy-Align
    ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
    -- ChatGPT
    ["<leader>;c"] = { "<cmd>ChatGPT<cr>" },
    ["<leader>;a"] = { "<cmd>ChatGPTActAs<cr>" },
    ["<leader>;e"] = { "<cmd>ChatGPTEditWithInstructions<cr>" },
    ["<leader>;r"] = { name = "ChatGPTRun" },
    ["<leader>;rg"] = { "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction" },
    ["<leader>;rT"] = { "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
    ["<leader>;rk"] = { "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
    ["<leader>;rd"] = { "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
    ["<leader>;rt"] = { "<cmd>ChatGPTRun add_test<cr>", desc = "Add Tests" },
    ["<leader>;ro"] = { "<cmd>ChatGPTRun optimize code<cr>", desc = "Optimize Code" },
    ["<leader>;rs"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
    ["<leader>;rf"] = { "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs" },
    ["<leader>;re"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain" },
    ["<leader>;rr"] = { "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Code Readability Analysis" },
    ["<leader>;rR"] = { "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen Edit" },
  },
  o = {
    -- line text-objects
    ["il"] = { ":normal vil<cr>", desc = "Inside line text object" },
    ["al"] = { ":normal val<cr>", desc = "Around line text object" },
  },
}
