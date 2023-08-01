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
        telescope = { enabled = true, style = "nvchad" },
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
          inlay_hints = { background = false },
        },
        flash = false,
      },
      custom_highlights = function(colors)
        return {
          -- italicize lsp inlay hints
          LspInlayHint = { style = { "italic" } },
          -- lightspeed-style highlighting for leap
          LeapMatch = { fg = colors.text, style = { "bold" } },
          LeapLabelPrimary = { fg = colors.pink, style = { "bold" } },
          LeapLabelSecondary = { fg = colors.blue, style = { "bold" } },
          -- hide results title in flat theme for telescope
          TelescopeResultsTitle = { fg = colors.mantle, bg = colors.none },
          -- dark prompt in flat theme for telescope
          TelescopePromptNormal = { fg = colors.text, bg = colors.crust },
          TelescopePromptBorder = { fg = colors.crust, bg = colors.crust },
          TelescopePromptPrefix = { fg = colors.flamingo, bg = colors.crust },
          -- make telescope and cmp selection color consistent
          PmenuSel = { bg = colors.surface0 },
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
  { import = "astrocommunity.indent.indent-tools-nvim" },
  { import = "astrocommunity.indent.indent-blankline-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  {
    "echasnovski/mini.indentscope",
    opts = {
      mappings = {
        object_scope = "io",
        object_scope_with_border = "ao",
        goto_top = "[o",
        goto_bottom = "]o",
      },
    },
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

  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
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

  { import = "astrocommunity.code-runner.compiler-nvim" },

  -- motion
  { import = "astrocommunity.motion.grapple-nvim" },
  {
    "cbochs/grapple.nvim",
    keys = {
      { "<leader>1", function() require("grapple").select { key = 1 } end, desc = "which_key_ignore" },
      { "<leader>2", function() require("grapple").select { key = 2 } end, desc = "which_key_ignore" },
      { "<leader>3", function() require("grapple").select { key = 3 } end, desc = "which_key_ignore" },
      { "<leader>4", function() require("grapple").select { key = 4 } end, desc = "which_key_ignore" },
      { "<leader><leader>a", "<cmd>GrappleTag<cr><cmd>redrawstatus<cr>", desc = "Add file" },
      { "<leader><leader>d", "<cmd>GrappleUntag<cr><cmd>redrawstatus<cr>", desc = "Remove file" },
      { "<leader><leader>t", "<cmd>GrappleToggle<cr><cmd>redrawstatus<cr>", desc = "Toggle a file" },
      { "<leader><leader>x", "<cmd>GrappleReset<cr><cmd>redrawstatus<cr>", desc = "Clear tags from current project" },
    },
  },

  { import = "astrocommunity.motion.portal-nvim" },

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
