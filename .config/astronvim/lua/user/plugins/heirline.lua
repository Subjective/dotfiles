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

    local ignored_buftypes = { "nofile", "prompt", "nowrite", "help", "quickfix", "terminal" }
    local function is_file()
      return not status.condition.buffer_matches({ buftype = ignored_buftypes }, vim.api.nvim_get_current_buf())
        or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t") == "[Command Line]"
    end

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.grapple,
      status.component.file_info {
        filename = { fallback = "[No Name]", modify = ":~:." },
        surround = { condition = is_file },
      },
      status.component.file_info {
        filetype = {},
        filename = false,
        file_icon = false,
        file_read_only = {},
        file_modified = false,
        surround = { condition = function() return not is_file() end },
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

    opts.winbar[1][2] = status.component.file_info {
      file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
      filename = { fallback = "[No Name]" }, -- set fallback to "[No Name]"
      file_modified = false,
      file_read_only = false,
      hl = status.hl.get_attributes("winbarnc", true),
      surround = false,
      update = "BufEnter",
    }

    opts.tabline[2] = status.heirline.make_buflist(status.component.tabline_file_info { filename = { fallback = "[No Name]" } }) -- set fallback to "[No Name]"
  end,
}
