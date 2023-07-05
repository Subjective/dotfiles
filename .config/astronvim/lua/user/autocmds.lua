local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FileType" }, {
  desc = "Don't auto comment new lines",
  group = augroup("dotfiles_git", { clear = true }),
  pattern = { "*" },
  command = "setlocal fo-=c fo-=r fo-=o",
})

autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = augroup("auto_spell", { clear = true }),
  pattern = { "gitcommit", "markdown", "mdx", "text", "plaintex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- autocmd("User", {
--   desc = "Hide tabline when only one buffer and one tab are open",
--   pattern = "AstroBufsUpdated",
--   group = augroup("autohidetabline", { clear = true }),
--   callback = function()
--     local new_showtabline = #vim.t.bufs > 1 and 2 or 1
--     if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
--   end,
-- })

autocmd({ "User" }, {
  desc = "Cleanup latexmk junk files upon exiting Vim",
  group = augroup("vimtex_autocleanup", { clear = true }),
  pattern = { "VimtexEventQuit" },
  command = "VimtexClean",
})
