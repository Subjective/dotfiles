local harpoon_components = {}
harpoon_components.index = {
  provider = function()
    local Marked = require "harpoon.mark"
    local filename = vim.api.nvim_buf_get_name(0)
    local success, index = pcall(Marked.get_index_of, filename)
    if success and index and index > 0 then
      return "󱡀 " .. index .. " "
    else
      return
    end
  end,
}

return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      harpoon_components.index,
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
