local astro_utils = require "astronvim.utils"

return {
  "AstroNvim/astrocommunity",

  -- language packs
  { import = "astrocommunity.pack.typescript" },

  -- colorschemes
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        noice = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        leap = true,
        octo = true,
      },
    },
  },

  -- indent
  { import = "astrocommunity.indent.indent-tools-nvim" },

  -- editor
  { import = "astrocommunity.editing-support.todo-comments-nvim" },

  { import = "astrocommunity.editing-support.refactoring-nvim" },
  {
    "ThePrimeagen/refactoring.nvim",
    init = function()
      astro_utils.set_mappings {
        n = {
          ["<leader>r"] = { name = "󰑌 Refactor" },
        },
        x = {
          ["<leader>r"] = { name = "󰑌 Refactor" },
        },
      }
    end,
  },

  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- media
  { import = "astrocommunity.media.vim-wakatime" },

  -- motion
  { import = "astrocommunity.motion.harpoon" },
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "which_key_ignore" },
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "which_key_ignore" },
      { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "which_key_ignore" },
      { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "which_key_ignore" },
    },
  },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.flit-nvim" },

  -- project
  { import = "astrocommunity.project.project-nvim" },
  {
    "ahmedkhalf/project.nvim",
    opts = { ignore_lsp = { "lua_ls", "texlab" } },
    keys = { { "<leader>fp", function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" } },
  },

  -- markdown and latex
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          require("which-key").register({
            ["p"] = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview" },
          }, { prefix = "<localleader>", buffer = event.buf })
        end,
      })
    end,
  },
}
