-- override the LSP setup handler function based on server name
-- return {
--   -- first function changes the default setup handler
--   function(server, opts) require("lspconfig")[server].setup(opts) end,
--   -- keys for a specific server name will be used for that LSP
--   lua_ls = function(server, opts)
--     -- custom lua_ls setup handler
--     require("lspconfig")["lua_ls"].setup(opts)
--   end,
-- }
