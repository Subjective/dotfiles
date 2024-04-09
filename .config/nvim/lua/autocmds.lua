local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command

autocmd({ "FileType" }, {
  desc = "Don't auto comment new lines",
  group = augroup("disable_autocomment", { clear = true }),
  pattern = "*",
  command = "setlocal fo-=c fo-=r fo-=o",
})

autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = augroup("auto_spell", { clear = true }),
  pattern = { "gitcommit", "markdown", "mdx", "text", "plaintex", "tex" },
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

autocmd({ "VimResized" }, {
  desc = "Automatically resize windows when resizing the terminal",
  group = augroup("autoresize_window", { clear = true }),
  pattern = "*",
  command = "wincmd =",
})

cmd("Redir", function(ctx)
  local lines = vim.split(vim.api.nvim_exec2(ctx.args, { output = true }).output, "\n", { plain = true })
  vim.cmd "new"
  vim.api.nvim_buf_set_option(0, "buflisted", false)
  vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = true })
  vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

autocmd({ "InsertEnter", "BufEnter", "BufLeave" }, {
  desc = "Automatically clear cmdline messages",
  group = augroup("autoclear_cmdline", { clear = true }),
  command = "echon ''",
})

-- if vim.env.KITTY_LISTEN_ON then
--   local cmd = require("astrocore").cmd
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
--           local bg_color = require("astroui").get_hlgroup("Normal").bg
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
