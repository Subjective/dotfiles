-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

local utils = require "astrocore"

---@type LazySpec
return {
  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "Saghen/blink.cmp",
    opts = {
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      opts.enable_autosnippets = true
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/nvim/lua/snippets/vscode" } } -- load vscode snippets
      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/snippets/lua" } -- load lua snippets
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
    opts = {
      highlights = false,
      direction = "float",
    },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      setup = {
        task_list = {
          direction = "bottom",
          bindings = {
            ["<C-l>"] = false,
            ["<C-h>"] = false,
            ["<C-k>"] = false,
            ["<C-j>"] = false,
            q = "<Cmd>close<CR>",
            J = "IncreaseDetail",
            K = "DecreaseDetail",
            ["<C-p>"] = "ScrollOutputUp",
            ["<C-n>"] = "ScrollOutputDown",
          },
        },
      },
      templates = {
        {
          name = "compile with compiler",
          builder = function() return { cmd = { "compiler" }, args = { vim.fn.expand "%:p" } } end,
        },
      },
    },
    config = function(_, opts)
      require("overseer").setup(opts.setup)
      vim.api.nvim_create_user_command("AutoCompile", function()
        require("overseer").run_template({ name = "compile with compiler" }, function(task)
          if task then
            task:add_component { "restart_on_save", paths = { vim.fn.expand "%:p" } }
          else
            vim.notify("Error setting up auto compilation", vim.log.levels.ERROR)
          end
        end)
      end, { desc = "Automatically compile the current file with `compiler` on save" })
      vim.api.nvim_create_user_command(
        "Compile",
        function() require("overseer").run_template { name = "compile with compiler" } end,
        { desc = "Compile the current file with `compiler`" }
      )
    end,
    keys = function()
      local prefix = "<leader>T"
      utils.set_mappings { n = { [prefix] = { name = "󱁤 Tasks" } } }
      return {
        { prefix .. "<CR>", "<Cmd>OverseerToggle<CR>", desc = "Toggle" },
        { prefix .. "a", "<Cmd>OverseerQuickAction<CR>", desc = "Quick Action" },
        { prefix .. "c", "<Cmd>Compile<CR>", desc = "Compile" },
        { prefix .. "C", "<Cmd>AutoCompile<CR>", desc = "Auto Compile" },
        { prefix .. "i", "<Cmd>OverseerInfo<CR>", desc = "Info" },
        { prefix .. "l", "<cmd>OverseerLoadBundle<cr>", desc = "Load bundle" },
        { prefix .. "r", "<Cmd>OverseerRun<CR>", desc = "Run" },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function(plugin)
      local package_manager = vim.fn.executable "yarn" and "yarn" or vim.fn.executable "npx" and "npx -y yarn" or false

      --- HACK: Use `yarn` or `npx` when possible, otherwise throw an error
      ---@see https://github.com/iamcco/markdown-preview.nvim/issues/690
      ---@see https://github.com/iamcco/markdown-preview.nvim/issues/695
      if not package_manager then error "Missing `yarn` or `npx` in the PATH" end

      local cmd = string.format(
        "!cd %s && cd app && COREPACK_ENABLE_AUTO_PIN=0 %s install --frozen-lockfile",
        plugin.dir,
        package_manager
      )

      vim.cmd(cmd)
    end,
    ft = { "markdown", "mdx" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "mdx" }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "markdown",
          "mdx",
        },
        callback = function(args)
          require("which-key").add {
            {
              buffer = args.buf,
              "<localleader>m",
              "<cmd>MarkdownPreviewToggle<cr>",
              desc = "Toggle Markdown Preview",
            },
          }
        end,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        -- your image configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      scratch = {},
      dashboard = {
        enabled = false,
      },
    },
    keys = {
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>>", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
  },
}
