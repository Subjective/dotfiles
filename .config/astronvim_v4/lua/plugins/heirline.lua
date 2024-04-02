---@type LazySpec
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    status.component.overseer = function()
      return {
        condition = function() return package.loaded["overseer"] end,
        init = function(self)
          self.overseer = require "overseer"
          self.tasks = self.overseer.task_list
          self.STATUS = self.overseer.constants.STATUS
        end,
        static = {
          symbols = {
            ["CANCELED"] = "",
            ["FAILURE"] = "󰅚",
            ["SUCCESS"] = "󰄴",
            ["RUNNING"] = "󰑮",
          },
          colors = {
            ["CANCELED"] = "gray",
            ["FAILURE"] = "red",
            ["SUCCESS"] = "green",
            ["RUNNING"] = "yellow",
          },
        },
        {
          condition = function(self) return #self.tasks.list_tasks() > 0 end,
          {
            provider = function(self)
              local tasks_by_status = self.overseer.util.tbl_group_by(self.tasks.list_tasks { unique = true }, "status")

              for _, _status in ipairs(self.STATUS.values) do
                local status_tasks = tasks_by_status[_status]
                if self.symbols[_status] and status_tasks then
                  self.color = self.colors[_status]
                  return string.format("  %s %s", self.symbols[_status], _status)
                end
              end
            end,
            hl = function(self) return { fg = self.color } end,
          },
        },
      }
    end

    status.component.grapple = function()
      return {
        provider = function()
          if require("grapple").exists() then return string.format(" %s ", require("grapple").key()) end
        end,
        condition = function() return package.loaded["grapple"] end,
        update = {
          "User",
          pattern = "GrappleStateUpdate",
          callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
        },
        init = require("astroui.status.init").update_events { "BufEnter" },
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
      status.component.overseer(),
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
