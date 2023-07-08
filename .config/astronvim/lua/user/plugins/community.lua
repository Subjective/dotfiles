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
      integrations = {
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
        octo = true,
      },
      custom_highlights = function(colors)
        return {
          -- lightspeed-style highlighting for leap
          LeapMatch = { fg = colors.text, style = { "bold", "nocombine" } },
          LeapLabelPrimary = { fg = colors.pink, style = { "bold", "nocombine" } },
          LeapLabelSecondary = { fg = colors.blue, style = { "bold", "nocombine" } },
        }
      end,
    },
  },

  -- indent
  { import = "astrocommunity.indent.indent-tools-nvim" },

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
      { "<leader>Rc", "<cmd>RunClose<cr>", desc = "Close Runner" },
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
    init = function() utils.set_mappings { n = { ["<leader><leader>"] = { name = "󰛢 Grapple" } } } end,
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
  {
    "cbochs/portal.nvim",
    cmd = { "Portal" },
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
        callback = function(event)
          require("which-key").register({
            ["p"] = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview" },
          }, { prefix = "<localleader>", buffer = event.buf })
        end,
      })
    end,
  },
}
