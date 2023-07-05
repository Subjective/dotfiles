local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local astro_utils = require "astronvim.utils"
local is_available = astro_utils.is_available

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

autocmd({ "BufEnter" }, {
  desc = "Configure git integration when editing dotfiles",
  group = augroup("dotfiles_git", { clear = true }),
  pattern = { "*" },
  callback = function(args)
    if vim.fn.expand "%" == "" or vim.api.nvim_get_option_value("buftype", { buf = args.buf }) == "nofile" then return end

    local home_dir = vim.env.HOME

    if not vim.g.dotfile_list then
      vim.g.dotfile_list =
        vim.fn.system("git -C $HOME --work-tree=" .. home_dir .. " --git-dir=" .. home_dir .. "/.cfg ls-tree --name-only -r HEAD")
    end

    local filename = vim.api.nvim_buf_get_name(0)
    local relative_filename = string.gsub(filename, home_dir .. "/", "", 1)

    if vim.fn.index(vim.fn.split(vim.g.dotfile_list, "\n"), relative_filename) ~= -1 then
      vim.env.GIT_DIR = home_dir .. "/.cfg"
      vim.env.GIT_WORK_TREE = home_dir
      if not is_available "gitsigns" then pcall(require, "gitsigns") end
    else
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end
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
