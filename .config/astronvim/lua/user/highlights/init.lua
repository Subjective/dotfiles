-- Add highlight groups in any theme
return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  local nontext = get_hlgroup "NonText"
  return {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
    CursorLineFold = { link = "CursorLineNr" }, -- highlight fold indicator as well as line number
    GitSignsCurrentLineBlame = { fg = nontext.fg, italic = true }, -- italicize git blame virtual text
    HighlightURL = { undercurl = true }, -- always underline URLs
    OctoEditable = { fg = "NONE", bg = "NONE" }, -- use treesitter for octo.nvim highlighting
  }
end
