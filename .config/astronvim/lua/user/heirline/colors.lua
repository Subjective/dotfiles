-- -- Customize colors for each element each element has a `_fg` and a `_bg`
-- return function(colors)
--   colors.git_branch_fg = require("astronvim.utils").get_hlgroup "Conditional"
--   return colors
-- end

return {
  buffer_active_bg = require("astronvim.utils").get_hlgroup("StatusLine").bg,
  buffer_bg = require("astronvim.utils").get_hlgroup("Normal").bg,
}
