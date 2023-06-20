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

  -- ui
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },

  -- editor
  { import = "astrocommunity.syntax.vim-easy-align" },
  { import = "astrocommunity.indent.indent-tools-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },

  -- motion
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.flit-nvim" },

  -- organization
  { import = "astrocommunity.project.project-nvim" },
  {
    "ahmedkhalf/project.nvim",
    opts = { ignore_lsp = { "lua_ls", "texlab" } },
  },
}
