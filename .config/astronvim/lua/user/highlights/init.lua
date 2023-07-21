-- Add highlight groups in any theme
local get_hlgroup = require("astronvim.utils").get_hlgroup
local nontext = get_hlgroup "NonText"

return {
  CursorLineFold = { link = "CursorLineNr" }, -- highlight fold indicator as well as line number
  GitSignsCurrentLineBlame = { fg = nontext.fg, italic = true }, -- italicize git blame virtual text
  HighlightURL = { undercurl = true }, -- always underline URLs
  LeapBackdrop = { link = "Comment" }, -- gray out the search area when leaping
  MsgArea = { link = "Comment" },
}
