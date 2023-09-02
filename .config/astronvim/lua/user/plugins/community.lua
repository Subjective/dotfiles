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
          -- hide results title in flat theme for telescope
          TelescopeResultsTitle = { fg = colors.mantle, bg = colors.none },
          -- dark prompt in flat theme for telescope
          TelescopePromptNormal = { fg = colors.text, bg = colors.crust },
          TelescopePromptBorder = { fg = colors.crust, bg = colors.crust },
          TelescopePromptPrefix = { fg = colors.flamingo, bg = colors.none },
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
    keys = function()
      local prefix = "<leader><leader>"
      return {
        { "<leader>1", function() require("grapple").select { key = 1 } end, desc = "Go to tag 1" },
        { "<leader>2", function() require("grapple").select { key = 2 } end, desc = "Go to tag 2" },
        { "<leader>3", function() require("grapple").select { key = 3 } end, desc = "Go to tag 3" },
        { "<leader>4", function() require("grapple").select { key = 4 } end, desc = "Go to tag 4" },
        { "<leader>'", "<cmd>GrappleToggle<cr><cmd>redrawstatus<cr>", desc = "Toggle file tag" },
        { prefix .. "a", "<cmd>GrappleTag<cr><cmd>redrawstatus<cr>", desc = "Add file" },
        { prefix .. "d", "<cmd>GrappleUntag<cr><cmd>redrawstatus<cr>", desc = "Remove file" },
        { prefix .. "t", "<cmd>GrappleToggle<cr><cmd>redrawstatus<cr>", desc = "Toggle a file" },
        { prefix .. "e", "<cmd>GrapplePopup tags<CR>", desc = "Select from tags" },
        { prefix .. "s", "<cmd>GrapplePopup scopes<CR>", desc = "Select a project scope" },
        { prefix .. "x", "<cmd>GrappleReset<cr><cmd>redrawstatus<cr>", desc = "Clear tags from current project" },
        { "<c-n>", "<cmd>GrappleCycle forward<CR>", desc = "Select next tag" },
        { "<c-p>", "<cmd>GrappleCycle backward<CR>", desc = "Select previous tag" },
      }
    end,
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
