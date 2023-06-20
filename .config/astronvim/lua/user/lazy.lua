return {
  -- Configure require("lazy").setup() options
  defaults = { lazy = true },
  performance = {
    rtp = {
      -- customize default disabled vim plugins
      disabled_plugins = {
        "matchit",
        "matchparen",
        "tohtml",
        "gzip",
        "zipPlugin",
        "netrwPlugin",
        "tarPlugin",
      },
    },
  },
}
