local Snacks = require "snacks"

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    notifier = {
      style = "minimal",
      top_down = false,
      margin = { top = 0, right = 1, bottom = 1 },
    },
    image = {},
    scratch = {},
    dashboard = {
      enabled = false,
    },
    -- Make indent scope keybinds use cursor position.
    scope = {
      cursor = true,
      keys = {
        textobject = {
          ii = {
            cursor = true,
          },
          ai = {
            cursor = true,
          },
        },
        jump = {
          ["[i"] = {
            cursor = true,
          },
          ["]i"] = {
            cursor = true,
          },
        },
      },
    },
  },
  keys = {
    { "<leader>fu", function() Snacks.picker.undo() end, desc = "Find in undo history" },
    {
      "<leader>f.",
      function()
        local function get_dotfiles()
          local dotfiles = {}
          local cmd = "git --git-dir="
            .. vim.env.HOME
            .. "/.cfg/ --work-tree="
            .. vim.env.HOME
            .. " ls-tree --full-tree -r --name-only HEAD"
          local handle = io.popen(cmd)
          if handle then
            for line in handle:lines() do
              table.insert(dotfiles, line)
            end
          else
            handle:close()
            print "Failed to execute git command"
          end
          return dotfiles
        end

        local files = get_dotfiles()

        return Snacks.picker.files {
          finder = function()
            local items = {}
            for i, file in ipairs(files) do
              table.insert(items, {
                idx = i,
                file = vim.env.HOME .. "/" .. file,
                text = file,
              })
            end
            return items
          end,
        }
      end,
      desc = "Find dotfiles",
    },
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>>", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  },
}
