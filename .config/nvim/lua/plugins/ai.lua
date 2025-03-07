local utils = require "astrocore"

utils.set_mappings {
  n = { ["<leader>;"] = { name = "󰧑 AI Assistant" } },
  x = { ["<leader>;"] = { name = "󰧑 AI Assistant" } },
}

---@type LazySpec
return {
  {
    "Exafunction/codeium.vim",
    cmd = "Codeium",
    init = function()
      vim.g.codeium_enabled = 0
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_idle_delay = 150
    end,
    config = function()
      vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-->", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
      vim.keymap.set("i", "<C-=>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
      vim.keymap.set("i", "<C-BS>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
    end,
    keys = {
      {
        "<leader>;;",
        function()
          vim.cmd.Codeium(vim.g.codeium_enabled == 0 and "Enable" or "Disable")
          utils.notify("Codeium " .. (vim.g.codeium_enabled == 0 and "Disabled" or "Enabled"))
        end,
        desc = "Toggle Codeium (global)",
      },
      {
        "<leader>;,",
        function()
          vim.cmd.Codeium(vim.b.codeium_enabled == 0 and "EnableBuffer" or "DisableBuffer")
          utils.notify("Codeium (buffer) " .. (vim.b.codeium_enabled == 0 and "Disabled" or "Enabled"))
        end,
        desc = "Toggle Codeium (buffer)",
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
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
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
