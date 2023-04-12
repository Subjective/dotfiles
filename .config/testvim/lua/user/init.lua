local config = {
  updater = {
    remote = "origin",     -- remote to use
    channel = "nightly",   -- "stable" or "nightly"
    version = "lastest",   -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
  },
  -- Set colorscheme to use
  -- colorscheme = "tokyonight-night",
  colorscheme = "catppuccin",
  --
  -- Configure plugins
  plugins = {
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim",      name = "catppuccin" },
    {
      "Exafunction/codeium.vim",
      enabled = true,
      cmd = "Codeium",
      init = function()
        vim.g.codeium_enabled = 0
        vim.g.codeium_disable_bindings = 1
        vim.g.codeium_idle_delay = 1500
      end,
      config = function()
        vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
        vim.keymap.set("i", "<C-->", function() return vim.fn["codeium#CycleCompletions"](0) end, { expr = true })
        vim.keymap.set("i", "<C-=>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
        vim.keymap.set("i", "<C-]>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
      end,
    },
    -- {
    --   "lewis6991/satellite.nvim",
    --   lazy = false,
    --   config = function()
    --     require("satellite").setup({
    --       current_only = false,
    --       winblend = 50,
    --       zindex = 40,
    --       excluded_filetypes = {
    --         "prompt",
    --         "noice",
    --         "notify",
    --         "alpha",
    --         "qf",
    --         "minimap",
    --         "toggleterm",
    --         "TelescopePrompt",
    --       },
    --       width = 2,
    --       handlers = {
    --         search = {
    --           enable = true,
    --         },
    --         diagnostic = {
    --           enable = true,
    --         },
    --         gitsigns = {
    --           enable = true,
    --           signs = {
    --             -- can only be a single character (multibyte is okay)
    --             add = "│",
    --             change = "│",
    --             delete = "-",
    --           },
    --         },
    --         marks = {
    --           enable = true,
    --           show_builtins = false, -- shows the builtin marks like [ ] < >
    --         },
    --       },
    --     })
    --   end,
    -- },
  }
}

return config
