local utils = require "astronvim.utils"

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
      term_colors = true,
      integrations = {
        ufo = false,
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
          inlay_hints = { background = false },
        },
        flash = false,
      },
      custom_highlights = function(colors)
        return {
          -- italicize lsp inlay hints
          LspInlayHint = { style = { "italic" } },
          -- lightspeed-style highlighting for leap
          LeapBackdrop = { link = "Comment" },
          LeapMatch = { fg = colors.text, style = { "bold" } },
          LeapLabelPrimary = { fg = colors.pink, style = { "bold" } },
          LeapLabelSecondary = { fg = colors.blue, style = { "bold" } },
          -- use subtle indentscope color
          MiniIndentscopeSymbol = { fg = colors.surface2, nocombine = true },
        }
      end,
    },
  },

  -- { import = "astrocommunity.colorscheme.vscode-nvim" },
  -- { import = "astrocommunity.colorscheme.nightfox-nvim" },
  -- { import = "astrocommunity.colorscheme.rose-pine" },
  -- { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  -- { import = "astrocommunity.colorscheme.github-nvim-theme" },
  -- { import = "astrocommunity.colorscheme.oxocarbon-nvim" },
  -- { import = "astrocommunity.colorscheme.gruvbox-nvim" },
  -- { import = "astrocommunity.colorscheme.everforest" },
  -- { import = "astrocommunity.colorscheme.dracula-nvim" },
  -- { import = "astrocommunity.colorscheme.helix-nvim" },
  -- { import = "astrocommunity.colorscheme.fluormachine-nvim" },
  -- { "maxmx03/fluoromachine.nvim", opts = { glow = true } },

  -- indent
  { import = "astrocommunity.indent.mini-indentscope" },
  {
    "echasnovski/mini.indentscope",
    dependencies = {
      "lukas-reineke/indent-blankline.nvim",
      opts = {
        show_trailing_blankline_indent = false,
        show_current_context = false,
      },
    },
    opts = function()
      local success, wk = pcall(require, "which-key")
      if success then
        local textobjects = {
          ["ii"] = [[inside indent scope]],
          ["ai"] = [[around indent scope]],
        }
        wk.register(textobjects, { mode = { "x", "o" } })
      end

      local indentscope = require "mini.indentscope"
      vim.defer_fn(function() indentscope.draw() end, 0)
      return {
        draw = {
          delay = 0,
          animation = indentscope.gen_animation.none(),
        },
        mappings = {
          object_scope = "ii",
          object_scope_with_border = "ai",
          goto_top = "[i",
          goto_bottom = "]i",
        },
        symbol = "▏",
        options = { try_as_border = true },
      }
    end,
  },

  -- editor
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  {
    "ThePrimeagen/refactoring.nvim",
    init = function()
      utils.set_mappings {
        n = { ["<leader>r"] = { name = "󰑌 Refactor" } },
        x = { ["<leader>r"] = { name = "󰑌 Refactor" } },
      }
    end,
  },

  -- media
  { import = "astrocommunity.media.vim-wakatime" },

  -- code-runner
  {
    init = function() utils.set_mappings { n = { ["<leader>R"] = { name = " Run" } } } end,
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects" },
    keys = {
      { "<leader>Rf", "<cmd>RunFile<cr>", desc = "Run File" },
      { "<leader>Rp", "<cmd>RunProject<cr>", desc = "Run Project" },
    },
    opts = {},
  },

  {
    import = "astrocommunity.code-runner.sniprun",
  },
  {
    "michaelb/sniprun",
    init = function() utils.set_mappings { n = { ["<leader>Rs"] = { name = " SnipRun" } } } end,
    keys = {
      { "<leader>R", ":SnipRun<cr>", silent = true, mode = "x", desc = "Run Snippet" },
      { "<leader>Rsc", "<cmd>SnipClose<cr>", desc = "Close" },
      { "<leader>Rsi", "<cmd>SnipInfo<cr>", desc = "Info" },
      { "<leader>Rsx", "<cmd>SnipReplMemoryClean<cr>", desc = "Clean REPL Memory" },
      { "<leader>Rsr", "<cmd>SnipReset<cr>", desc = "Reset" },
    },
  },

  { import = "astrocommunity.code-runner.overseer-nvim" },
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
    "stevearc/resession.nvim",
    opts = function(_, opts) opts.extensions = utils.extend_tbl(opts.extensions, { overseer = {}, grapple = {} }) end,
  },
  {
    "Zeioth/compiler.nvim",
    dependencies = { "stevearc/overseer.nvim" },
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    opts = {},
  },

  -- motion
  { import = "astrocommunity.motion.portal-nvim" },
  {
    "cbochs/portal.nvim",
    opts = {
      window_options = {
        border = "rounded",
      },
    },
  },

  -- terminal integration
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  {
    "willothy/flatten.nvim",
    opts = {
      window = {
        open = "alternate",
      },
      callbacks = {
        post_open = function(bufnr, winnr, ft)
          vim.api.nvim_set_current_win(winnr)
          -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
          if ft == "gitcommit" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              buffer = bufnr,
              once = true,
              callback = function()
                vim.defer_fn(function() vim.api.nvim_buf_delete(bufnr, {}) end, 50)
              end,
            })
          end
        end,
      },
    },
  },

  -- markdown and latex
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "mdx" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "mdx" }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "markdown",
          "mdx",
        },
        callback = function(args)
          require("which-key").register({
            ["m"] = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview" },
          }, { prefix = "<localleader>", buffer = args.buf })
        end,
      })
    end,
  },
}
