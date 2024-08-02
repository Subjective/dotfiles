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
  vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = true })
  vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

autocmd({ "InsertEnter", "BufEnter", "BufLeave" }, {
  desc = "Automatically clear cmdline messages",
  group = augroup("autoclear_cmdline", { clear = true }),
  command = "echon ''",
})

autocmd({ "UIEnter", "ColorScheme" }, {
  desc = "Set terminal background to Neovim colorscheme's background",
  group = augroup("terminal_background_sync", { clear = true }),
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

autocmd("UILeave", {
  desc = "Set terminal background to original background upon exiting Neovim",
  group = augroup("terminal_background_sync", { clear = true }),
  callback = function() io.write "\027]111\027\\" end,
})
