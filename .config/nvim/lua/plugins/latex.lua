---@type LazySpec
return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "skim"

      -- add which-key mapping descriptions for VimTex
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Set up VimTex Which-Key descriptions",
        group = vim.api.nvim_create_augroup("vimtex_mapping_descriptions", { clear = true }),
        pattern = "tex",
        callback = function(args)
          local wk = require "which-key"
          local prefix = "<localleader>l"
          local ts = "ts"
          local cs = "cs"
          local ds = "ds"
          wk.add {
            mode = "n", -- NORMAL mode
            buffer = args.buf, -- Specify a buffer number for buffer local mappings to show only in tex buffers
            { prefix, group = "VimTeX" },
            { prefix .. "a", desc = "Show Context Menu" },
            { prefix .. "C", desc = "Full Clean" },
            { prefix .. "c", desc = "Clean" },
            { prefix .. "e", desc = "Show Errors" },
            { prefix .. "G", desc = "Show Status for All" },
            { prefix .. "g", desc = "Show Status" },
            { prefix .. "i", desc = "Show Info" },
            { prefix .. "I", desc = "Show Full Info" },
            { prefix .. "k", desc = "Stop VimTeX" },
            { prefix .. "K", desc = "Stop All VimTeX" },
            { prefix .. "L", desc = "Compile Selection" },
            { prefix .. "l", desc = "Compile" },
            { prefix .. "m", desc = "Show Imaps" },
            { prefix .. "o", desc = "Show Compiler Output" },
            { prefix .. "q", desc = "Show VimTeX Log" },
            { prefix .. "s", desc = "Toggle Main" },
            { prefix .. "t", desc = "Open Table of Contents" },
            { prefix .. "T", desc = "Toggle Table of Contents" },
            { prefix .. "v", desc = "View Compiled Document" },
            { prefix .. "X", desc = "Reload VimTeX State" },
            { prefix .. "x", desc = "Reload VimTeX" },
            { ts, group = "VimTeX Toggles & Cycles" },
            { ts .. "$", desc = "Cycle inline, display & numbered equation" },
            { ts .. "c", desc = "Toggle star of command" },
            { ts .. "d", desc = "Cycle (), \\left(\\right) [,...]" },
            { ts .. "D", desc = "Reverse Cycle (), \\left(\\right) [, ...]" },
            { ts .. "e", desc = "Toggle star of environment" },
            { ts .. "f", desc = "Toggle a/b vs \\frac{a}{b}" },
            { "[/", desc = "Previous start of a LaTeX comment" },
            { "[*", desc = "Previous end of a LaTeX comment" },
            { "[[", desc = "Previous beginning of a section" },
            { "[]", desc = "Previous end of a section" },
            { "[m", desc = "Previous \\begin" },
            { "[M", desc = "Previous \\end" },
            { "[n", desc = "Previous start of a math zone" },
            { "[N", desc = "Previous end of a math zone" },
            { "[r", desc = "Previous \\begin{frame}" },
            { "[R", desc = "Previous \\end{frame}" },
            { "]/", desc = "Next start of a LaTeX comment %" },
            { "]*", desc = "Next end of a LaTeX comment %" },
            { "][", desc = "Next beginning of a section" },
            { "]]", desc = "Next end of a section" },
            { "]m", desc = "Next \\begin" },
            { "]M", desc = "Next \\end" },
            { "]n", desc = "Next start of a math zone" },
            { "]N", desc = "Next end of a math zone" },
            { "]r", desc = "Next \\begin{frame}" },
            { "]R", desc = "Next \\end{frame}" },
            { cs .. "c", desc = "Change surrounding command" },
            { cs .. "e", desc = "Change surrounding environment" },
            { cs .. "$", desc = "Change surrounding math zone" },
            { cs .. "d", desc = "Change surrounding delimiter" },
            { ds .. "c", desc = "Delete surrounding command" },
            { ds .. "e", desc = "Delete surrounding environment" },
            { ds .. "$", desc = "Delete surrounding math zone" },
            { ds .. "d", desc = "Delete surrounding delimiter" },
          }
          -- VimTeX Text Objects without variants with targets.vim
          wk.add {
            mode = "o", -- Operator pending mode
            buffer = args.buf,
            { "ic", desc = [[LaTeX Command]] },
            { "ac", desc = [[LaTeX Command]] },
            { "id", desc = [[LaTeX Math Delimiter]] },
            { "ad", desc = [[LaTeX Math Delimiter]] },
            { "ie", desc = [[LaTeX Environment]] },
            { "ae", desc = [[LaTeX Environment]] },
            { "i$", desc = [[LaTeX Math Zone]] },
            { "a$", desc = [[LaTeX Math Zone]] },
            { "iP", desc = [[LaTeX Section, Paragraph, ...]] },
            { "aP", desc = [[LaTeX Section, Paragraph, ...]] },
            { "im", desc = [[LaTeX Item]] },
            { "am", desc = [[LaTeX Item]] },
          }
        end,
      })
    end,
    config = function()
      vim.api.nvim_create_autocmd({ "User" }, {
        desc = "Cleanup latexmk junk files upon exiting Vim",
        group = vim.api.nvim_create_augroup("vimtex_autocleanup", { clear = true }),
        pattern = { "VimtexEventQuit" },
        command = "silent! VimtexClean",
      })
    end,
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
    -- using treesitter.
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    opts = { use_treesitter = false },
    -- treesitter is required for markdown
    ft = { "tex", "markdown" },
  },
}
