local mocha = require("catppuccin.palettes").get_palette "mocha"
require("leap").opts.highlight_unlabeled_phase_one_targets = true

local get_hlgroup = require("astronvim.utils").get_hlgroup
local comment = get_hlgroup "Comment"

return {
  -- lightspeed-style highlighting
  LeapMatch = { fg = mocha.text, bg = comment.fg, bold = true, nocombine = true },
  LeapLabelPrimary = { fg = mocha.pink, bg = comment.fg, bold = true, nocombine = true },
  LeapLabelSecondary = { fg = mocha.blue, bg = comment.fg, bold = true, nocombine = true },
}
