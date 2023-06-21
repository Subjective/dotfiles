local utils = require "astronvim.utils"
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
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "User AstroFile",
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      opts.enable_autosnippets = true
      require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/astronvim/lua/user/snippets/vscode" } } -- load vscode snippets
      require("luasnip.loaders.from_lua").load { paths = "~/.config/astronvim/lua/user/snippets/lua" } -- load lua snippets
    end,
  },
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-calc",
      {
        "js-everts/cmp-tailwind-colors",
        opts = {
          format = function(itemColor)
            return {
              fg = itemColor,
              bg = itemColor,
              text = " ",
            }
          end,
        },
      },
      "kdheepak/cmp-latex-symbols",
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "latex_symbols", priority = 700, option = { strategy = 2 } },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "calc", priority = 700 },
      }

      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if item.kind == "Color" then
          item = require("cmp-tailwind-colors").format(entry, item)
          if item.kind == "Color" then return format_kinds(entry, item) end
          return item
        end
        return format_kinds(entry, item)
      end

      local luasnip = require "luasnip"
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      return require("astronvim.utils").extend_tbl(opts, {
        mapping = {
          -- <C-n> and <C-p> for navigating snippets
          ["<C-n>"] = cmp.mapping(function()
            if luasnip.jumpable(1) then luasnip.jump(1) end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function()
            if luasnip.jumpable(-1) then luasnip.jump(-1) end
          end, { "i", "s" }),
        },
        experimental = { ghost_text = true },
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        -- "*",
        javascriptreact = { names = true, tailwind = "both" },
        javascript = { names = true, tailwind = "both" },
        typescript = { names = true, tailwind = "both" },
        typescriptreact = { names = true, tailwind = "both" },
        "!javascriptreact",
        "!javascript",
        "!typescript",
        "!typescriptreact",
        "!cmp_menu",
      },
      user_default_options = {
        RRGGBBAA = true,
        AARRGGBB = true,
        -- mode = "virtualtext",
        names = false,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = { render = "minimal", timeout = 0 },
  },
}
