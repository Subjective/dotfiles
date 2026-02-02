-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
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
    { "Subjective/nvim-treesitter-textsubjects", branch = "feat-custom-keymap-desc" },
  },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "javascript",
      "typescript",
      "swift",
      "html",
      "css",
      "cpp",
      "python",
      "java",
      "bash",
      "markdown",
      "markdown_inline",
      "regex",
      "vim",
      "latex",
      "tsx",
      "diff",
      "git_rebase",
      "gitcommit",
      "git_config",
      "gitignore",
    })
    opts.auto_install = vim.fn.executable "tree-sitter" == 1
    opts.matchup = { enable = true }
    opts.indent = { enable = true, disable = { "python" } }

    opts.highlight.disable = function(lang, _)
      -- fix compatibility issues with vimtex
      local disabled_languages = { "latex" }
      return vim.tbl_contains(disabled_languages, lang)
    end
    opts.textsubjects = {
      enable = true,
      prev_selection = { keymap = ",", desc = "Previous textsubject" }, -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = { query = "textsubjects-smart", desc = "Smart textsubject" },
        ["a;"] = { query = "textsubjects-container-outer", desc = "around textsubject" },
        ["i;"] = { query = "textsubjects-container-inner", desc = "inside textsubject" },
      },
    }
  end,
}
