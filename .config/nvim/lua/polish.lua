-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
vim.filetype.add {
  extension = {
    mdx = "mdx",
  },
}
vim.treesitter.language.register("markdown", "mdx")

-- disable auto_hlsearch
vim.on_key(function() end, vim.api.nvim_create_namespace "auto_hlsearch")

-- remove "How-to disable mouse" menu item
vim.cmd [[aunmenu PopUp.How-to\ disable\ mouse]]
vim.cmd [[aunmenu PopUp.-1-]]

require "autocmds"
