vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Don't auto comment new lines",
  group = vim.api.nvim_create_augroup("dotfiles_git", { clear = true }),
  pattern = { "*" },
  command = "setlocal fo-=c fo-=r fo-=o",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  pattern = { "gitcommit", "markdown", "mdx", "text", "plaintex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  desc = "Configure git integration when editing dotfiles",
  group = vim.api.nvim_create_augroup("dotfiles_git", { clear = true }),
  pattern = { "*" },
  callback = function()
    local home_dir = os.getenv "HOME"
    if not vim.g.dotfile_list then
      vim.g.dotfile_list =
        vim.fn.system("(cd $HOME && git --work-tree=" .. home_dir .. " --git-dir=" .. home_dir .. "/.cfg ls-tree --name-only -r HEAD)")
    end

    local buffer_file = vim.fn.expand "%:p"
    local buffer_relative_file
    if home_dir then
      buffer_relative_file = string.gsub(buffer_file, home_dir .. "/", "", 1)
    else
      buffer_relative_file = buffer_file
    end

    if vim.fn.index(vim.fn.split(vim.g.dotfile_list, "\n"), buffer_relative_file) ~= -1 then
      vim.env.GIT_DIR = home_dir .. "/.cfg"
      vim.env.GIT_WORK_TREE = home_dir
      pcall(require, "gitsigns")
    else
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end
  end,
})

-- vim.api.nvim_create_autocmd("User", {
--   desc = "Hide tabline when only one buffer and one tab are open",
--   pattern = "AstroBufsUpdated",
--   group = vim.api.nvim_create_augroup("autohidetabline", { clear = true }),
--   callback = function()
--     local new_showtabline = #vim.t.bufs > 1 and 2 or 1
--     if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
--   end,
-- })

vim.api.nvim_create_autocmd({ "User" }, {
  desc = "Cleanup latexmk junk files upon exiting Vim",
  group = vim.api.nvim_create_augroup("vimtex_autocleanup", { clear = true }),
  pattern = { "VimtexEventQuit" },
  command = "VimtexClean",
})
