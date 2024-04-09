local utils = require "astronvim.utils"

return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = {}
      end,
      config = function()
        vim.keymap.del({ "x", "o" }, "z%") -- don't conflict with leap

        local success, wk = pcall(require, "which-key")
        if success then
          local motions = {
            ["%"] = [[Go forwards next matching word or seek to one]],
            ["g%"] = [[Go backwards to previous matching word or seek to one]],
            ["[%"] = [[Previous matching word]],
            ["]%"] = [[Next matching word]],
          }
          wk.register(motions, { mode = { "n", "x" } })
          local textobjects = {
            ["i%"] = [[inside matching pair]],
            ["a%"] = [[around matching pair]],
          }
          wk.register(textobjects, { mode = { "x", "o" } })
          local normalmaps = {
            ["z%"] = [[Go inside nearest matching pair ]],
          }
          wk.register(normalmaps, { mode = "n" })
        end
      end,
    },
    { "Subjective/nvim-treesitter-textsubjects", branch = "feat-custom-keymap-desc" },
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
    opts.highlight.disable = function(lang, bufnr)
      -- fix compatibility issues with vimtex
      local disabled_languages = { "latex" }
      return vim.tbl_contains(disabled_languages, lang) or large_buf(_, bufnr)
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
