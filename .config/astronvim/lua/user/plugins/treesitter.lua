local utils = require "astronvim.utils"

return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup", fullwidth = 1, highlight = "Normal", syntax_hl = 1 }
      end,
    },
    { "Subjective/nvim-treesitter-textsubjects" },
  },
  opts = function(_, opts)
    -- Ensure that opts.ensure_installed exists and is a table or string "all".
    if not opts.ensure_installed then
      opts.ensure_installed = {}
    elseif opts.ensure_installed == "all" then
      return
    end
    -- Add the required file types to opts.ensure_installed.
    utils.list_insert_unique(opts.ensure_installed, {
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

    local large_buf = opts.highlight.disable
    -- fix compatibility issues with vimtex
    opts.highlight.disable = function(lang, bufnr)
      local disabled_languages = {
        "latex",
      }
      return vim.tbl_contains(disabled_languages, lang) or large_buf(_, bufnr)
    end
    opts.textsubjects = {
      enable = true,
      prev_selection = ",", -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = { query = "textsubjects-smart", desc = "Smart textsubject" },
        [";"] = { query = "textsubjects-container-outer", desc = "Outer textsubject" },
        ["i;"] = { query = "textsubjects-container-inner", desc = "Inner textsubject" },
      },
    }
  end,
}
