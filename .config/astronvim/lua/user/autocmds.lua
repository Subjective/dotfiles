local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FileType" }, {
  desc = "Don't auto comment new lines",
  group = augroup("disable_autocomment", { clear = true }),
  pattern = "*",
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

-- if vim.env.KITTY_LISTEN_ON then
--   local cmd = require("astronvim.utils").cmd
--
--   for _, color in ipairs(vim.fn.split(cmd { "kitty", "@", "get-colors" } or "", "\n")) do
--     local orig_bg = color:match "^background%s+(#[0-9a-fA-F]+)$"
--     if orig_bg then
--       local function set_bg(new_color) cmd { "kitty", "@", "set-colors", ("background=%s"):format(new_color) } end
--
--       local autocmd_group = augroup("kitty_background", { clear = true })
--
--       autocmd("ColorScheme", {
--         desc = "Set Kitty background to colorscheme's background",
--         group = autocmd_group,
--         callback = function()
--           local bg_color = require("astronvim.utils").get_hlgroup("Normal").bg
--           if not bg_color or bg_color == "NONE" then
--             bg_color = orig_bg
--           elseif type(bg_color) == "number" then
--             bg_color = string.format("#%06x", bg_color)
--           end
--
--           set_bg(bg_color)
--         end,
--       })
--
--       autocmd("VimLeave", {
--         desc = "Set Kitty background back to original background",
--         group = autocmd_group,
--         callback = function() set_bg(orig_bg) end,
--       })
--       break
--     end
--   end
-- end
