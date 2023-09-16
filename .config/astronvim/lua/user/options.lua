return {
  opt = {
    spell = false,
    wrap = false,
    conceallevel = 2,
    clipboard = "",
    splitkeep = "screen",
    list = true, -- show whitespace characters
    listchars = { tab = "→\\", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
    swapfile = false,
    spellfile = vim.fn.expand "~/.config/astronvim/lua/user/spell/en.utf-8.add",
    cmdheight = 1,
    thesaurus = vim.fn.expand "~/.config/astronvim/lua/user/spell/mthesaur.txt",
    shada = string.gsub(vim.opt.shada._value, "'(%d+)", "'" .. 500), -- increase default oldfiles history length to 500
    showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1,
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available)
    ui_notifications_enabled = true, -- enable notifications
    resession_enabled = true, -- enable resession
    git_worktrees = { { toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/.cfg" } }, -- allow detached git_worktrees to be detected
  },
}
