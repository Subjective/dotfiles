return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"

    status.component.grapple = {
      provider = function()
        local key = require("grapple").key()
        return " " .. key .. " "
      end,
      condition = require("grapple").exists,
      update = { "User", pattern = "GrappleStateUpdate", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
    }

    local ignored_buftypes = { "nofile", "prompt", "nowrite", "help", "quickfix" }
    local ignored_filetypes = { "toggleterm" }
    local function is_file()
      return not status.condition.buffer_matches({ buftype = ignored_buftypes, filetype = ignored_filetypes }, 0)
        or vim.fn.expand "%" == "[Command Line]"
    end

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.grapple,
      {
        flexible = 10,
        status.component.file_info {
          filename = { fallback = "[No Name]", modify = ":~:." },
          surround = { condition = is_file },
        },
        status.component.file_info {
          filename = {},
          surround = { condition = is_file },
        },
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

    local astro_disable = opts.opts.disable_winbar_cb
    opts.opts.disable_winbar_cb = function(args)
      if vim.bo[args.buf].filetype == "neo-tree" then return end
      return astro_disable(args)
    end
  end,
}
