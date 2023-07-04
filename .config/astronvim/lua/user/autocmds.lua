-- don't auto comment new lines
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "*" }, command = "setlocal fo-=c fo-=r fo-=o" })

-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "mdx", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- set git repo for dotfiles
vim.api.nvim_create_autocmd({ "User AstroFile" }, {
  pattern = { "*" },
  group = vim.api.nvim_create_augroup("dotfiles_git", { clear = true }),
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
    else
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end
  end,
})

-- automatically hide tabline when a single buffer is open
-- vim.api.nvim_create_autocmd("User", {
--   desc = "Hide tabline when only one buffer and one tab",
--   pattern = "AstroBufsUpdated",
--   group = vim.api.nvim_create_augroup("autohidetabline", { clear = true }),
--   callback = function()
--     local new_showtabline = #vim.t.bufs > 1 and 2 or 1
--     if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
--   end,
-- })

-- cleanup latexmk junk files upon exit
vim.api.nvim_create_autocmd({ "User" }, { pattern = { "VimtexEventQuit" }, command = "VimtexClean" })
