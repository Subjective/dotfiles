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
        function() require("wtf").diagnose() end,
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
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        provider = "external",
        provider_opts = {
          external_terminal_cmd = "tmux split-window -h -p 30 -c " .. vim.fn.getcwd() .. " %s",
        },
      },
    },
    keys = {
      { "<leader>;c", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>;f", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>;r", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>;C", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>;b", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>;s", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>;s",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>;a", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>;d", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
