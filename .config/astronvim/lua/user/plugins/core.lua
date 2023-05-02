return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "                                                    ",
        " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                    ",
      }
      return opts
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "User AstroFile",
  },
  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
      }
    end,
  },
  {
    "stevearc/resession.nvim",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      opts.enable_autosnippets = true
      require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/astronvim/lua/user/snippets/vscode" } } -- load snippets paths
      require("luasnip.loaders.from_lua").load { paths = "~/.config/astronvim/lua/user/snippets/lua" }
    end,
  },
}
