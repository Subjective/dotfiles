-- Customize Heirline options
return {
  -- -- Customize different separators between sections
  -- separators = {
  -- 	breadcrumbs = " > ",
  -- 	tab = { "", "" },
  -- },
  -- -- Customize colors for each element each element has a `_fg` and a `_bg`
  -- colors = function(colors)
  --   colors.git_branch_fg = require("astronvim.utils").get_hlgroup "Conditional"
  --   return colors
  -- end,
  -- -- Customize attributes of highlighting in Heirline components
  -- attributes = {
  --   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
  --   git_branch = { bold = true }, -- bold the git branch statusline component
  -- },
  -- -- Customize if icons should be highlighted
  icon_highlights = {
    breadcrumbs = true, -- LSP symbols in the breadcrumbs
    file_icon = {
      winbar = false, -- Filetype icon in the winbar inactive windows
      statusline = true, -- Filetype icon in the statusline
      tabline = true, -- Filetype icon in the tabline
    },
  },
}
