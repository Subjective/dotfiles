local utils = require "astronvim.utils"

return {
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    keys = {
      { "s", "<Plug>(leap-forward-to)", mode = { "n" }, desc = "Leap forward to" },
      { "S", "<Plug>(leap-backward-to)", mode = { "n" }, desc = "Leap backward to" },
      { "z", "<Plug>(leap-forward-to)", mode = { "o" }, desc = "Leap forward to" },
      { "Z", "<Plug>(leap-backward-to)", mode = { "o" }, desc = "Leap backward to" },
      { "x", "<Plug>(leap-forward-till)", mode = { "o" }, desc = "Leap forward till" },
      { "X", "<Plug>(leap-backward-till)", mode = { "o" }, desc = "Leap backward till" },
      { "gs", "<Plug>(leap-from-window)", mode = { "n" }, desc = "Leap from window" },
    },
    init = function() -- https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=100")
          vim.opt.guicursor:append { "a:Cursor/lCursor" }
        end,
        pattern = "LeapEnter",
      })
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=0")
          vim.opt.guicursor:remove { "a:Cursor/lCursor" }
        end,
        pattern = "LeapLeave",
      })
    end,
    opts = function()
      require("leap").add_repeat_mappings(";", ",", {
        relative_directions = true,
        modes = { "n" },
      })
      return {
        highlight_unlabeled_phase_one_targets = true,
      }
    end,
  },
  {
    "ggandor/flit.nvim",
    dependencies = { "ggandor/leap.nvim" },
    keys = {
      { "f", mode = { "n", "x", "o" }, desc = "Flit forward to" },
      { "F", mode = { "n", "x", "o" }, desc = "Flit backward to" },
      { "t", mode = { "n", "x", "o" }, desc = "Flit forward till" },
      { "T", mode = { "n", "x", "o" }, desc = "Flit backward till" },
    },
    opts = {
      labeled_modes = "nx",
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = false,
        },
      },
      prompt = {
        enabled = false,
      },
      remote_op = {
        motion = true,
      },
    },
    keys = {
      {
        "<c-s>",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Flash Treesitter Search",
      },
    },
  },
  {
    "Subjective/grapple.nvim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Grapple" },
    opts = function()
      local scope = require "grapple.scope"
      local resession = require "resession"
      local files = require "resession.files"
      local util = require "resession.util"

      local get_session_path = function(session_name)
        if session_name then
          local filename = util.get_session_file(session_name)
          local data = files.load_json_file(filename)
          local formatted = ""
          if data then
            if data.tab_scoped then
              local tab_cwd = data.tabs[1].cwd
              formatted = formatted .. string.format("%s (tab)", tab_cwd)
            else
              formatted = formatted .. string.format("%s", data.global.cwd)
            end
          end
          return formatted
        end
      end

      local session_path = scope.resolver(function()
        if resession.get_current() then
          return string.format("%s", get_session_path(resession.get_current()))
        else
          return nil
        end
      end, { cache = false, persist = false })

      local resolver = scope.fallback {
        session_path,
        require("grapple.scope_resolvers").git,
      }

      local format_title = function()
        local current_session = resession.get_current()
        if current_session then
          local title = string.format(" %s [%s] ", current_session, util.shorten_path(get_session_path(current_session)))
          return #title > 50 and string.format(" %s ", current_session) or title
        else
          local git_root = require("grapple.state").ensure_loaded(require("grapple.scope_resolvers").git)
          return string.format(" %s ", git_root ~= vim.env.HOME and util.shorten_path(git_root) or git_root)
        end
      end

      resession.add_hook("pre_save", function()
        if require("resession").get_current() == nil then
          require("grapple").save()
          require("grapple.settings").integrations.resession = true

          local grapple_state = require("grapple.state").state()
          for loaded_scope, _ in pairs(grapple_state) do
            if loaded_scope ~= get_session_path(resession.get_current()) then require("grapple.state").unload(loaded_scope) end
          end
        end
      end)
      resession.add_hook("pre_load", function()
        require("grapple").save()
        require("grapple.settings").integrations.resession = true
      end)

      return {
        scope = resolver,
        popup_tags_title = format_title,
        popup_options = {
          border = "rounded",
        },
      }
    end,
    init = function() utils.set_mappings { n = { ["<leader><leader>"] = { name = "󰛢 Grapple" } } } end,
    keys = function()
      local prefix = "<leader><leader>"

      local find_buffer_by_type = function(type)
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")
          if ft == type then return true end
        end
        return false
      end
      local conditional_action = function(condition, primary_action, alternate_action)
        if condition then
          primary_action()
        else
          alternate_action()
        end
      end

      return {
        { "<leader>1", function() require("grapple").select { key = 1 } end, desc = "Go to tag 1" },
        { "<leader>2", function() require("grapple").select { key = 2 } end, desc = "Go to tag 2" },
        { "<leader>3", function() require("grapple").select { key = 3 } end, desc = "Go to tag 3" },
        { "<leader>4", function() require("grapple").select { key = 4 } end, desc = "Go to tag 4" },
        { "<leader>'", "<cmd>GrappleToggle<cr>", desc = "Toggle file tag" },
        { prefix .. "a", "<cmd>GrappleTag<cr>", desc = "Add file" },
        { prefix .. "d", "<cmd>GrappleUntag<cr>", desc = "Remove file" },
        { prefix .. "t", "<cmd>GrappleToggle<cr>", desc = "Toggle a file" },
        { prefix .. "e", "<cmd>GrapplePopup tags<CR>", desc = "Select from tags" },
        { prefix .. "s", "<cmd>GrapplePopup scopes<CR>", desc = "Select a project scope" },
        { prefix .. "x", "<cmd>GrappleReset<cr>", desc = "Clear tags from current project" },
        {
          "<c-n>",
          function() conditional_action(find_buffer_by_type "qf", vim.cmd.QNext, require("grapple").cycle_forward) end,
          desc = "Next Grapple tag or quickfix list item",
        },
        {
          "<c-p>",
          function() conditional_action(find_buffer_by_type "qf", vim.cmd.QPrev, require("grapple").cycle_backward) end,
          desc = "Previous Grapple tag or quickfix list item",
        },
      }
    end,
  },
}
