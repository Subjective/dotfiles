return {
  {
    lazy = false,
    "tokyonight.nvim",
  },
  {
    lazy = false,
    "catppuccin",
  },
  {
    lazy = false,
    "arzg/vim-colors-xcode",
  },
  {
    lazy = false,
    "gruvbox.nvim",
    opts = {
      integrations = {
        mini = true,
        leap = true,
        markdown = true,
        cmp = true,
      },
    },
  },
  {
    lazy = false,
    "christoomey/vim-tmux-navigator",
  },
  {
    "ellisonleao/glow.nvim",
    opts = {
      style = "~/.config/glowstyles/dracula.json",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          require("which-key").register({
            ["p"] = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview" },
          }, { prefix = "<localleader>", buffer = vim.api.nvim_get_current_buf() })
        end,
      })
    end,
  },
}
