return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    opts.statusline = {
      -- statusline
      hl = { fg = "fg", bg = "bg" },
      -- status.component.mode({ mode_text = { padding = { left = 1, right = 1 } } }), -- add the mode text
      status.component.mode(),
      status.component.git_branch(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.file_info {
        filetype = false,
        filename = { fallback = "Empty" },
        file_modified = false,
        -- file_modified = { padding = { left = 0 } },
        file_read_only = { padding = { right = 1 } },
        surround = { separator = "none" },
      },
      -- status.component.separated_path {
      --   padding = { left = 0 },
      --   separator = "/",
      --   max_depth = 2,
      --   path_func = status.provider.filename { modify = ":.:h" },
      --   update = { "BufEnter", "BufLeave", "DirChanged" },
      -- },
      -- status.component.file_info {
      --   file_icon = false,
      --   filetype = false,
      --   filename = { fallback = "Empty" },
      -- },
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.nav(),
      status.component.mode { surround = { separator = "right" } },
    }
    -- opts.winbar = nil
    return opts
  end,
}