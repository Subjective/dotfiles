local mocha = require("catppuccin.palettes").get_palette "mocha"

return {
  -- lightspeed-style highlighting
  LeapMatch = { fg = mocha.text, bold = true, nocombine = true },
  LeapLabelPrimary = { fg = mocha.pink, bold = true, nocombine = true },
  LeapLabelSecondary = { fg = mocha.blue, bold = true, nocombine = true },
}
