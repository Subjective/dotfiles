return {
  {
    "lervag/vimtex",
    lazy = false,
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
    -- using treesitter.
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    opts = { use_treesitter = true },
    -- treesitter is required for markdown
    ft = { "tex", "markdown" },
  },
}