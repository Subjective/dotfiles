return {
  "AstroNvim/astrocommunity",
  -- language packs
  { import = "astrocommunity.pack.typescript" },
  -- { import = "astrocommunity.pack.tailwindcss" },

  -- colorschemes
  { import = "astrocommunity.colorscheme.tokyonight" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.gruvbox" },

  -- ui
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },
  -- { import = "astrocommunity.indent.indent-blankline-nvim" },
  -- { import = "astrocommunity.indent.mini-indentscope" },

  -- editor
  { import = "astrocommunity.syntax.vim-easy-align" },
  { import = "astrocommunity.indent.indent-tools-nvim" },

  -- organization
  { import = "astrocommunity.project.project-nvim" },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
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
      },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    opts = { ignore_lsp = { "lua_ls", "texlab" } },
  },
}
