-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "goolord/alpha-nvim",
    enabled = false,
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
      opts.config.opts.noautocmd = false
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      opts.enable_autosnippets = true
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/astronvim/lua/user/snippets/vscode" } } -- load vscode snippets
      require("luasnip.loaders.from_lua").load { paths = "~/.config/astronvim/lua/user/snippets/lua" } -- load lua snippets
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-calc",
      "kdheepak/cmp-latex-symbols",
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

      return require("astrocore").extend_tbl(opts, {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<S-CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          -- <C-n> and <C-p> for navigating snippets
          ["<C-n>"] = cmp.mapping(function()
            if luasnip.jumpable(1) then luasnip.jump(1) end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function()
            if luasnip.jumpable(-1) then luasnip.jump(-1) end
          end, { "i", "s" }),
        },
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "*",
        javascriptreact = { names = true, tailwind = "lsp" },
        javascript = { names = true, tailwind = "lsp" },
        typescript = { names = true, tailwind = "lsp" },
        typescriptreact = { names = true, tailwind = "lsp" },
        "!javascriptreact",
        "!javascript",
        "!typescript",
        "!typescriptreact",
        "!cmp_menu",
        "!TelescopeResults",
        "!lazy",
        "!neo-tree",
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
    enabled = false,
  },
  {
    "akinsho/toggleterm.nvim",
    opts = { highlights = false },
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        backend = { "telescope", "builtin" },
        telescope = {
          layout_strategy = "horizontal",
          layout_config = {
            preview_cutoff = false,
            width = function(_, max_columns, _) return math.min(max_columns, 80) end,
            height = function(_, _, max_lines) return math.min(max_lines, 15) end,
          },
        },
      },
    },
  },
}
