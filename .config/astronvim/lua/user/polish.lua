-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
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

  require "user.autocmds"
end
