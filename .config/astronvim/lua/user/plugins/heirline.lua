return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"

    status.component.grapple = function()
      local available, grapple = pcall(require, "grapple")
      return {
        provider = function()
          if available then
            if grapple.exists() then return string.format(" %s ", grapple.key()) end
          end
        end,
        update = { "User", pattern = "GrappleStateUpdate", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
        init = require("astronvim.utils.status.init").update_events { "BufEnter" },
      }
    end

    status.component.smart_file_info = function()
      local ignored_buftypes = { "nofile", "prompt", "nowrite", "help", "quickfix" }
      local ignored_filetypes = { "toggleterm" }
      local is_file = function()
        return not status.condition.buffer_matches({ buftype = ignored_buftypes, filetype = ignored_filetypes }, 0)
          or vim.fn.expand "%" == "[Command Line]"
      end

      return {
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
      }
    end

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.grapple(),
      status.component.smart_file_info(),
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
