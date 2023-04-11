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

-- set git repo for dotfiles and refresh gitsigns
local home_dir = os.getenv "HOME"
local git_file_list = vim.fn.system(
  "(cd $HOME && git --work-tree=" .. home_dir .. " --git-dir=" .. home_dir .. "/.cfg ls-tree --name-only -r HEAD)"
)

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

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    -- require("astronvim.utils").notify("buftype: " .. vim.bo.buftype .. "filetype: " .. vim.bo.filetype)
    if
      vim.bo.filetype and vim.tbl_contains(filetype_exclude, vim.bo.filetype)
      or vim.bo.buftype and vim.tbl_contains(buftype_exclude, vim.bo.buftype)
    then
      -- require("astronvim.utils").notify("excluding")
      return
    end

    local buffer_file = vim.fn.expand "%:p"
    local buffer_relative_file
    if home_dir then
      buffer_relative_file = string.gsub(buffer_file, home_dir .. "/", "", 1)
    else
      buffer_relative_file = buffer_file
    end

    if vim.fn.index(vim.fn.split(git_file_list, "\n"), buffer_relative_file) ~= -1 then
      vim.env.GIT_DIR = home_dir .. "/.cfg"
      vim.env.GIT_WORK_TREE = home_dir
    else
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end
  end,
})

local iterm_profile = os.getenv "ITERM_PROFILE"
if iterm_profile then
  local function set_colorscheme(colorscheme)
    return string.format('call chansend(v:stderr, "\\e]50;SetProfile=%s\\x7")', colorscheme)
  end
  vim.cmd(set_colorscheme(vim.g.colors_name))
  vim.api.nvim_create_autocmd({ "VimLeave" }, { pattern = { "*" }, command = set_colorscheme(iterm_profile) })
end
