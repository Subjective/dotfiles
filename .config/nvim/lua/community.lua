-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

local utils = require "astrocore"

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.python-ruff" },

  -- colorschemes
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@type CatppuccinOptions
    opts = {
      term_colors = true,
      integrations = {
        telescope = { enabled = true, style = "nvchad" },
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
        snacks = {
          enabled = true,
          indent_scope_color = "surface2",
        },
        render_markdown = true,
        flash = false,
      },
      custom_highlights = function(colors)
        return {
          TabLineFill = { link = "NormalNC" },
          -- italicize lsp inlay hints
          LspInlayHint = { style = { "italic" } },
          -- lightspeed-style highlighting for leap
          LeapBackdrop = { link = "Comment" },
          LeapMatch = { fg = colors.text, style = { "bold" } },
          LeapLabel = { fg = colors.pink, style = { "bold" } },
          -- hide results title in flat theme for telescope
          TelescopeResultsTitle = { fg = colors.mantle, bg = colors.none },
          -- dark prompt in flat theme for telescope
          TelescopePromptNormal = { fg = colors.text, bg = colors.crust },
          TelescopePromptBorder = { fg = colors.crust, bg = colors.crust },
          TelescopePromptPrefix = { fg = colors.flamingo, bg = colors.none },
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
  { import = "astrocommunity.media.img-clip-nvim" },

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

  -- terminal integration
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  {
    "willothy/flatten.nvim",
    opts = {
      window = {
        open = "alternate",
      },
      hooks = {
        post_open = function(bufnr, _, ft, _)
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

  -- search
  { import = "astrocommunity.search.grug-far-nvim" },
  -- ai
  { import = "astrocommunity.recipes.ai" },

  -- markdown and latex
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "codecompanion" },
    },
  },
}
