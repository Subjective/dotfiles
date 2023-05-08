local utils = require "astronvim.utils"
function utils.list_remove(tbl, vals)
  if type(vals) ~= "table" then vals = { vals } end
  for _, val in ipairs(vals) do
    for i = #tbl, 1, -1 do
      if tbl[i] == val then table.remove(tbl, i) end
    end
  end
end

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
        { "lua_ls", "tsserver", "tailwindcss", "vimls", "clangd", "marksman", "grammarly", "pyright", "texlab" }
      )
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    config = function(_, opts)
      local mason_null_ls = require "mason-null-ls"
      local null_ls = require "null-ls"
      -- Ensure that opts.ensure_installed exists and is a table.
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add to opts.ensure_installed using vim.list_extend.
      utils.list_insert_unique(opts.ensure_installed, { "stylua", "eslint_d" })
      -- Remove lsps added by an astrocommunity language pack
      utils.list_remove(opts.ensure_installed, { "rustywind" })
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
