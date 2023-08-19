return {
  -- Configure require("lazy").setup() options
  defaults = { lazy = true },
  change_detection = {
    notify = false,
  },
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
