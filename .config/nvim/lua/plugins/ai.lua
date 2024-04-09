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
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions", "ChatGPTRun" },
    init = function()
      utils.set_mappings {
        n = { ["<leader>;r"] = { name = "ChatGPT: Run" } },
        x = { ["<leader>;r"] = { name = "ChatGPT: Run" } },
      }
    end,
    opts = function()
      require("cmp").setup.filetype({ "chatgpt-input" }, {
        completion = {
          autocomplete = false,
        },
      })
      return {
        popup_window = {
          border = {
            highlight = "TelescopePreviewBorder",
          },
          win_options = {
            winhighlight = "Normal:TelescopePreviewNormal,FloatBorder:FloatBorder",
          },
        },
        system_window = {
          border = {
            highlight = "TelescopePromptBorder",
          },
          win_options = {
            winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
          },
        },
        popup_input = {
          border = {
            highlight = "TelescopePromptBorder",
          },
          win_options = {
            winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
          },
        },
        settings_window = {
          border = {
            highlight = "TelescopePromptBorder",
          },
          win_options = {
            winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
          },
        },
        chat = {
          sessions_window = {
            border = {
              highlight = "TelescopePromptBorder",
            },
            win_options = {
              winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
            },
          },
        },
      }
    end,
    keys = {
      { "<leader>;c", "<cmd>ChatGPT<cr>", desc = "ChatGPT" },
      { "<leader>;a", "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT: Act As" },
      { "<leader>;C", "<cmd>ChatGPTCompleteCode<cr>", desc = "ChatGPT: Complete Code" },
      {
        "<leader>;e",
        "<cmd>ChatGPTEditWithInstructions<cr>",
        mode = { "n", "x" },
        desc = "ChatGPT: Edit With Instructions",
      },
      { "<leader>;rg", "<cmd>ChatGPTRun grammar_correction<cr>", mode = { "n", "x" }, desc = "Grammar Correction" },
      { "<leader>;rT", "<cmd>ChatGPTRun translate<cr>", mode = { "n", "x" }, desc = "Translate" },
      { "<leader>;rk", "<cmd>ChatGPTRun keywords<cr>", mode = { "n", "x" }, desc = "Keywords" },
      { "<leader>;rd", "<cmd>ChatGPTRun docstring<cr>", mode = { "n", "x" }, desc = "Docstring" },
      { "<leader>;rt", "<cmd>ChatGPTRun add_tests<cr>", mode = { "n", "x" }, desc = "Add Tests" },
      { "<leader>;ro", "<cmd>ChatGPTRun optimize_code<cr>", mode = { "n", "x" }, desc = "Optimize Code" },
      { "<leader>;rs", "<cmd>ChatGPTRun summarize<cr>", mode = { "n", "x" }, desc = "Summarize" },
      { "<leader>;rf", "<cmd>ChatGPTRun fix_bugs<cr>", mode = { "n", "x" }, desc = "Fix Bugs" },
      { "<leader>;re", "<cmd>ChatGPTRun explain_code<cr>", mode = { "n", "x" }, desc = "Explain Code" },
      { "<leader>;rR", "<cmd>ChatGPTRun roxygen_edit<cr>", mode = { "n", "x" }, desc = "Roxygen Edit" },
      {
        "<leader>;rr",
        "<cmd>ChatGPTRun code_readability_analysis<cr>",
        mode = { "n", "x" },
        desc = "Code Readabiliy Analysis",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
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
}
