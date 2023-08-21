-- Add highlight groups in any theme
local get_hlgroup = require("astronvim.utils").get_hlgroup
local nontext = get_hlgroup "NonText"

return {
  CursorLineFold = { link = "CursorLineNr" }, -- highlight fold indicator as well as line number
  HighlightURL = { undercurl = true }, -- always underline URLs
  LeapBackdrop = { link = "Comment" }, -- gray out the search area when leaping
}
