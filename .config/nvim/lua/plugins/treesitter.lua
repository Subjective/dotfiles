-- Customize Treesitter

---@type LazySpec
return {
  {
    "andymass/vim-matchup",
    init = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = {}
      vim.g.matchup_treesitter_stopline = 10000
      vim.g.matchup_delim_stopline = 10000
      vim.g.matchup_matchparen_stopline = 10000
    end,
    config = function()
      vim.keymap.del({ "x", "o" }, "z%") -- don't conflict with leap

      local success, wk = pcall(require, "which-key")
      if success then
        -- motions
        wk.add {
          mode = { "n", "x" },
          { "%", desc = [[Go forwards next matching word or seek to one]] },
          { "g%", desc = [[Go backwards to previous matching word or seek to one]] },
          { "[%", desc = [[Previous matching word]] },
          { "]%", desc = [[Next matching word]] },
        }
        -- textobjects
        wk.add {
          mode = { "x", "o" },
          { "i%", desc = [[inside matching pair]] },
          { "a%", desc = [[around matching pair]] },
        }
        -- normalmaps
        wk.add {
          mode = "n",
          { "z%", desc = [[Go inside nearest matching pair ]] },
        }
      end
    end,
  },
  {
    -- TODO: https://github.com/RRethy/nvim-treesitter-textsubjects/issues/52
    --
    -- "Subjective/nvim-treesitter-textsubjects",
    -- branch = "feat-custom-keymap-desc",
    -- dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- config = function()
    --   require("nvim-treesitter-textsubjects").configure {
    --     prev_selection = { keymap = ",", desc = "Previous textsubject" },
    --     keymaps = {
    --       ["."] = { query = "textsubjects-smart", desc = "Smart textsubject" },
    --       ["a;"] = { query = "textsubjects-container-outer", desc = "around textsubject" },
    --       ["i;"] = { query = "textsubjects-container-inner", desc = "inside textsubject" },
    --     },
    --   }
    -- end,
  },
}
