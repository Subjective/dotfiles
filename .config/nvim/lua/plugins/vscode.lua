if not vim.g.vscode then return {} end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local opt = vim.tbl_get(opts, "options", "opt")
      if opt then opt.cmdheight = nil end

      local maps = assert(opts.mappings)

      -- buffer management
      maps.n["L"] = "<Cmd>Tabnext<CR>"
      maps.n["H"] = "<Cmd>Tabprevious<CR>"
    end,
  },
}
