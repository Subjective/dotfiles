local utils = require "astronvim.utils"

return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table.
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add tsserver to opts.ensure_installed using vim.list_extend.
      utils.list_insert_unique(
        opts.ensure_installed,
        { "lua_ls", "tsserver", "tailwindcss", "cssls", "vimls", "clangd", "marksman", "grammarly", "pyright", "texlab" }
      )
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    config = function(_, opts)
      local mason_null_ls = require "mason-null-ls"
      -- Ensure that opts.ensure_installed exists and is a table.
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add to opts.ensure_installed using vim.list_extend.
      utils.list_insert_unique(opts.ensure_installed, { "stylua" })
      -- run setup
      mason_null_ls.setup(opts)
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table.
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add to opts.ensure_installed using table.insert.
      utils.list_insert_unique(opts.ensure_installed, "python")
    end,
  },
}
