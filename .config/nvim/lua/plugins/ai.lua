local utils = require "astrocore"

utils.set_mappings {
  n = { ["<leader>;"] = { name = "󰧑 AI Assistant" } },
  x = { ["<leader>;"] = { name = "󰧑 AI Assistant" } },
}

---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        keymap = {
          accept = false, -- handled by completion engine
          next = "<C-=>",
          prev = "<C-->",
        },
      },
    },
    keys = {
      {
        "<leader>;;",
        function() require("copilot.suggestion").toggle_auto_trigger() end,
        desc = "Toggle Copilot",
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              -- set the ai_accept function
              ai_accept = function()
                if require("copilot.suggestion").is_visible() then
                  require("copilot.suggestion").accept()
                  return true
                end
              end,
            },
          },
        },
      },
    },
  },
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = { "WTF", "WTFSearch" },
    opts = {},
    keys = {
      {
        "gw",
        mode = { "n" },
        function() require("wtf").ai() end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "gW",
        function() require("wtf").search() end,
        desc = "Search diagnostic with Google",
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          slash_commands = {
            ["file"] = {
              callback = "strategies.chat.slash_commands.file",
              description = "Select a file using Snacks picker",
              opts = {
                provider = "snacks",
                contains_code = true,
              },
            },
            ["buffer"] = {
              callback = "strategies.chat.slash_commands.buffer",
              description = "Select a buffer using Snacks picker",
              opts = {
                provider = "snacks",
                contains_code = true,
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "o3-mini",
              },
            },
          })
        end,
      },
      display = {
        chat = {
          window = {
            opts = {
              number = false,
              relativenumber = false,
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>;c",
        "<cmd>CodeCompanionChat<cr>",
        desc = "Open AI Chat",
      },
      {
        "<leader>;a",
        "<cmd>CodeCompanionActions<cr>",
        desc = "AI Actions",
      },
      {
        mode = { "n", "x" },
        "<leader>;e",
        "<cmd>CodeCompanion /explain<cr>",
        desc = "Explain code",
      },
      {
        mode = { "n", "x" },
        "<leader>;f",
        "<cmd>CodeCompanion /fix<cr>",
        desc = "Fix code",
      },
      {
        mode = { "x" },
        "<leader>;;",
        "<cmd>CodeCompanion<cr>",
        desc = "Ask AI",
      },
    },
  },
}
