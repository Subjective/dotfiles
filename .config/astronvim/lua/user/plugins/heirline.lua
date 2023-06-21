return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"

    status.component.grapple = {
      provider = function()
        local success, key = pcall(require("grapple").key, { buffer = 0 })
        if success and key and key > 0 then
          return " " .. key .. " "
        else
          return
        end
      end,
    }

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.grapple,
      status.component.file_info {
        filetype = false,
        filename = false,
        file_modified = false,
        file_read_only = false,
        surround = { separator = "none" },
      },
      status.component.separated_path {
        padding = { left = 0 },
        separator = "/",
        max_depth = 2,
        path_func = status.provider.filename { modify = ":.:h" },
        update = { "BufEnter", "BufLeave", "DirChanged" },
      },
      status.component.file_info {
        file_icon = false,
        filetype = false,
        filename = { fallback = "Empty" },
      },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.nav(),
      status.component.mode { surround = { separator = "right" } },
    }
    return opts
  end,
}
