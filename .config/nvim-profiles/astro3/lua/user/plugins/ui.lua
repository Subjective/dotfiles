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
  },
}
