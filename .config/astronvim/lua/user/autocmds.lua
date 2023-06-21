-- Don't auto comment new lines
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

-- create user command to set git repo for dotfiles and refresh gitsigns
vim.api.nvim_create_user_command("DotfilesGit", function()
  vim.g.home_dir = os.getenv "HOME"
  vim.g.dotfile_list = vim.fn.system(
    "(cd $HOME && git --work-tree=" .. vim.g.home_dir .. " --git-dir=" .. vim.g.home_dir .. "/.cfg ls-tree --name-only -r HEAD)"
  )

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
      local buftype_exclude = {
        "terminal",
        "nofile",
      }
      local filetype_exclude = {
        "help",
        "startify",
        "aerial",
        "alpha",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "neo-tree",
        "Trouble",
        "nofile",
      }
      if
        vim.bo.filetype and vim.tbl_contains(filetype_exclude, vim.bo.filetype)
        or vim.bo.buftype and vim.tbl_contains(buftype_exclude, vim.bo.buftype)
      then
        return
      end

      local buffer_file = vim.fn.expand "%:p"
      local buffer_relative_file
      if vim.g.home_dir then
        buffer_relative_file = string.gsub(buffer_file, vim.g.home_dir .. "/", "", 1)
      else
        buffer_relative_file = buffer_file
      end

      if vim.fn.index(vim.fn.split(vim.g.dotfile_list, "\n"), buffer_relative_file) ~= -1 then
        vim.env.GIT_DIR = vim.g.home_dir .. "/.cfg"
        vim.env.GIT_WORK_TREE = vim.g.home_dir
      else
        vim.env.GIT_DIR = nil
        vim.env.GIT_WORK_TREE = nil
      end
    end,
  })

  vim.cmd "silent! bufdo e"
end, {})

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
