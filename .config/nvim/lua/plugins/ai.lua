local utils = require "astrocore"

utils.set_mappings {
  n = { ["<leader>;"] = { name = "󰧑 AI Assistant" } },
  x = { ["<leader>;"] = { name = "󰧑 AI Assistant" } },
}

---@type LazySpec
return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
        win = {
          keys = {
            prompt = false,
          },
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>;a",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>;;",
        function()
          local nes = require "sidekick.nes"
          nes.toggle()
          utils.notify("Next edit suggestions " .. (nes.enabled and "enabled" or "disabled"))
        end,
        desc = "Toggle Next Edit Suggestions",
      },
      {
        "<leader>;s",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>;d",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>;t",
        function() require("sidekick.cli").send { msg = "{this}" } end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>;f",
        function() require("sidekick.cli").send { msg = "{file}" } end,
        desc = "Send File",
      },
      {
        "<leader>;v",
        function() require("sidekick.cli").send { msg = "{selection}" } end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
    },
  },
}
