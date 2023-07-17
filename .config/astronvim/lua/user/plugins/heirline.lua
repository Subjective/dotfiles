return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"

    status.component.grapple = {
      provider = function()
        local available, grapple = pcall(require, "grapple")
        if available then
          local key = grapple.key { buffer = 0 }
          if key ~= nil then return " " .. key .. " " end
        end
      end,
    }

    local ignored_buftypes = { "nofile", "prompt", "help", "quickfix", "terminal" }
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.grapple,
      status.component.file_info {
        filename = { modify = ":~:." }, -- Set relative path name
        surround = {
          condition = function() -- Only show filename when its file, not neotree, telescope, etc
            return not status.condition.buffer_matches({
              buftype = ignored_buftypes,
            }, vim.api.nvim_get_current_buf())
          end,
        },
      },
      status.component.file_info {
        filetype = {},
        filename = false,
        file_icon = false,
        file_read_only = false,
        file_modified = false,
        surround = {
          condition = function()
            return status.condition.buffer_matches({
              buftype = ignored_buftypes,
            }, vim.api.nvim_get_current_buf())
          end,
        },
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
  end,
}
