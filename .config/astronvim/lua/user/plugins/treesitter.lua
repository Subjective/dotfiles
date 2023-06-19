local utils = require "astronvim.utils"

return {
  "nvim-treesitter/nvim-treesitter",
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
    -- fix compatibility issues with vimtex
    opts.highlight.disable = { "latex" }
    -- opts.additional_vim_regex_highlighting = { "latex", "markdown" } -- enable vimtex compatibility with md plugins
    return opts
  end,
  dependencies = {
    { "andymass/vim-matchup", init = function() vim.g.matchup_matchparen_deferred = 1 end },
    {
      "RRethy/nvim-treesitter-textsubjects",
      config = function()
        require("nvim-treesitter.configs").setup {
          textsubjects = {
            enable = true,
            prev_selection = ",", -- (Optional) keymap to select the previous selection
            keymaps = {
              ["."] = "textsubjects-smart",
              [";"] = "textsubjects-container-outer",
              ["i;"] = "textsubjects-container-inner",
            },
          },
        }
      end,
    },
  },
}
