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

-- FIX: Improve performance hit to startup time

-- -- set git repo for dotfiles and refresh gitsigns
-- local home_dir = os.getenv "HOME"
-- local git_file_list = vim.fn.system(
--   "(cd $HOME && git --work-tree=" .. home_dir .. " --git-dir=" .. home_dir .. "/.cfg ls-tree --name-only -r HEAD)"
-- )
--
-- local buftype_exclude = {
--   "terminal",
--   "nofile",
-- }
-- local filetype_exclude = {
--   "help",
--   "startify",
--   "aerial",
--   "alpha",
--   "dashboard",
--   "lazy",
--   "neogitstatus",
--   "NvimTree",
--   "neo-tree",
--   "Trouble",
--   "nofile",
-- }
--
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     if
--       vim.bo.filetype and vim.tbl_contains(filetype_exclude, vim.bo.filetype)
--       or vim.bo.buftype and vim.tbl_contains(buftype_exclude, vim.bo.buftype)
--     then
--       return
--     end
--
--     local buffer_file = vim.fn.expand "%:p"
--     local buffer_relative_file
--     if home_dir then
--       buffer_relative_file = string.gsub(buffer_file, home_dir .. "/", "", 1)
--     else
--       buffer_relative_file = buffer_file
--     end
--
--     if vim.fn.index(vim.fn.split(git_file_list, "\n"), buffer_relative_file) ~= -1 then
--       vim.env.GIT_DIR = home_dir .. "/.cfg"
--       vim.env.GIT_WORK_TREE = home_dir
--     else
--       vim.env.GIT_DIR = nil
--       vim.env.GIT_WORK_TREE = nil
--     end
--   end,
-- })

-- automatically hide tabline when a single buffer is open
vim.api.nvim_create_autocmd("User", {
  desc = "Hide tabline when only one buffer and one tab",
  pattern = "AstroBufsUpdated",
  group = vim.api.nvim_create_augroup("autohidetabline", { clear = true }),
  callback = function()
    local new_showtabline = #vim.t.bufs > 1 and 2 or 1
    if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
  end,
})

-- fix heirline flicker with vimtex when cmdheight=0 and cleanup latexmk junk files upon exit
vim.api.nvim_create_autocmd({ "User" }, { pattern = { "VimtexEventInitPre" }, command = "set cmdheight=1" })
vim.api.nvim_create_autocmd({ "User" }, { pattern = { "VimtexEventQuit" }, command = "VimtexClean" })

-- add which-key mapping descriptions for VimTex
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.tex",
  callback = function()
    local wk = require "which-key"
    local opts = {
      mode = "n", -- NORMAL mode
      buffer = vim.api.nvim_get_current_buf(), -- Specify a buffer number for buffer local mappings to show only in tex buffers
    }
    local mappings = {
      ["<localleader>l"] = {
        name = "+VimTeX",
        a = "Show Context Menu",
        C = "Full Clean",
        c = "Clean",
        e = "Show Errors",
        G = "Show Status for All",
        g = "Show Status",
        i = "Show Info",
        I = "Show Full Info",
        k = "Stop VimTeX",
        K = "Stop All VimTeX",
        L = "Compile Selection",
        l = "Compile",
        m = "Show Imaps",
        o = "Show Compiler Output",
        q = "Show VimTeX Log",
        s = "Toggle Main",
        t = "Open Table of Contents",
        T = "Toggle Table of Contents",
        v = "View Compiled Document",
        X = "Reload VimTeX State",
        x = "Reload VimTeX",
      },
      ["ts"] = {
        name = "VimTeX Toggles & Cycles", -- optional group name
        ["$"] = "Cycle inline, display & numbered equation",
        c = "Toggle star of command",
        d = "Cycle (), \\left(\\right) [,...]",
        D = "Reverse Cycle (), \\left(\\right) [, ...]",
        e = "Toggle star of environment",
        f = "Toggle a/b vs \\frac{a}{b}",
      },
      ["[/"] = "Previous start of a LaTeX comment",
      ["[*"] = "Previous end of a LaTeX comment",
      ["[["] = "Previous beginning of a section",
      ["[]"] = "Previous end of a section",
      ["[m"] = "Previous \\begin",
      ["[M"] = "Previous \\end",
      ["[n"] = "Previous start of a math zone",
      ["[N"] = "Previous end of a math zone",
      ["[r"] = "Previous \\begin{frame}",
      ["[R"] = "Previous \\end{frame}",
      ["]/"] = "Next start of a LaTeX comment %",
      ["]*"] = "Next end of a LaTeX comment %",
      ["]["] = "Next beginning of a section",
      ["]]"] = "Next end of a section",
      ["]m"] = "Next \\begin",
      ["]M"] = "Next \\end",
      ["]n"] = "Next start of a math zone",
      ["]N"] = "Next end of a math zone",
      ["]r"] = "Next \\begin{frame}",
      ["]R"] = "Next \\end{frame}",
      ["cs"] = {
        c = "Change surrounding command",
        e = "Change surrounding environment",
        ["$"] = "Change surrounding math zone",
        d = "Change surrounding delimiter",
      },
      ["ds"] = {
        c = "Delete surrounding command",
        e = "Delete surrounding environment",
        ["$"] = "Delete surrounding math zone",
        d = "Delete surrounding delimiter",
      },
    }
    wk.register(mappings, opts)
    -- VimTeX Text Objects without variants with targets.vim
    opts = {
      mode = "o", -- Operator pending mode
      buffer = vim.api.nvim_get_current_buf(),
    }
    local objects = {
      ["ic"] = [[LaTeX Command]],
      ["ac"] = [[LaTeX Command]],
      ["id"] = [[LaTeX Math Delimiter]],
      ["ad"] = [[LaTeX Math Delimiter]],
      ["ie"] = [[LaTeX Environment]],
      ["ae"] = [[LaTeX Environment]],
      ["i$"] = [[LaTeX Math Zone]],
      ["a$"] = [[LaTeX Math Zone]],
      ["iP"] = [[LaTeX Section, Paragraph, ...]],
      ["aP"] = [[LaTeX Section, Paragraph, ...]],
      ["im"] = [[LaTeX Item]],
      ["am"] = [[LaTeX Item]],
    }
    wk.register(objects, opts)
  end,
})
