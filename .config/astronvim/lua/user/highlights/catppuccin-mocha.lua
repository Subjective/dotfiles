local mocha = require("catppuccin.palettes").get_palette "mocha"
require("leap").opts.highlight_unlabeled_phase_one_targets = true

return {
  -- lightspeed-style highlighting
  LeapMatch = { fg = mocha.text, bold = true, nocombine = true },
  LeapLabelPrimary = { fg = mocha.red, bold = true, nocombine = true },
  LeapLabelSecondary = { fg = mocha.blue, bold = true, nocombine = true },
}
