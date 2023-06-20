return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "andymass/vim-matchup", init = function() vim.g.matchup_matchparen_deferred = 1 end },
    { "RRethy/nvim-treesitter-textsubjects" },
  },
  opts = function(_, opts)
    opts.auto_install = vim.fn.executable "tree-sitter" == 1
    opts.matchup = { enable = true }
    opts.indent = { enable = true, disable = { "python" } }
    -- fix compatibility issues with vimtex
    opts.highlight.disable = { "latex" }
    -- opts.additional_vim_regex_highlighting = { "latex", "markdown" } -- enable vimtex compatibility with md plugins
    opts.textsubjects = {
      enable = true,
      prev_selection = ",", -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    }
    return opts
  end,
}
