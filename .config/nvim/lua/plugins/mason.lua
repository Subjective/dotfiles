-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "typescript-language-server",
        "tailwindcss-language-server",
        "css-lsp",
        "vim-language-server",
        "clangd",
        "marksman",
        "ocaml-lsp",
        "texlab",
        "grammarly-languageserver",

        -- install formatters
        "stylua",
        "clang-format",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
