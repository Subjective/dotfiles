local utils = require "astrocore"

---@type LazySpec
return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "User AstroFile",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    opts = {},
    keys = { { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" } },
  },
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    opts = {},
    cmd = "Trouble",
    keys = function()
      local prefix = "<leader>x"
      utils.set_mappings { n = { [prefix] = { name = "󰔫 Trouble" } } }
      return {
        { prefix .. "r", "<cmd>Trouble lsp_references toggle<cr>", desc = "References" },
        { prefix .. "d", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "Definitions" },
        { prefix .. "D", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "Type Definitions" },
        { prefix .. "i", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "Implementations" },
        { prefix .. "x", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
        { prefix .. "X", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
        { prefix .. "q", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
        { prefix .. "l", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
        { prefix .. "t", "<cmd>TodoTrouble<cr>", desc = "TODOs" },
        { prefix .. "T", "<cmd>TodoTrouble<cr>", desc = "TODO/FIX/FIXME" },
      }
    end,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        lua = { template = { annotation_convention = "ldoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
      },
    },
    init = function() utils.set_mappings { n = { ["<leader>a"] = { desc = "󰏫 Annotate" } } } end,
    keys = {
      { "<leader>a<cr>", function() require("neogen").generate { type = "current" } end, desc = "Current" },
      { "<leader>ac", function() require("neogen").generate { type = "class" } end, desc = "Class" },
      { "<leader>af", function() require("neogen").generate { type = "func" } end, desc = "Function" },
      { "<leader>at", function() require("neogen").generate { type = "type" } end, desc = "Type" },
      { "<leader>aF", function() require("neogen").generate { type = "file" } end, desc = "File" },
    },
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeFocus", "UndotreeHide", "UndotreeShow", "UndotreeToggle" },
    keys = {
      { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
    },
  },
  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "x" }, desc = "Align" },
      { "gA", mode = { "n", "x" }, desc = "Align with preview" },
    },
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<s-h>", mode = { "x" } },
      { "<s-l>", mode = { "x" } },
      { "<s-j>", mode = { "x" } },
      { "<s-k>", mode = { "x" } },
    },
    opts = {
      mappings = {
        left = "<s-h>",
        right = "<s-l>",
        down = "<s-j>",
        up = "<s-k>",
        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
      },
    },
  },
  {
    "axieax/urlview.nvim",
    cmd = "UrlView",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = {},
    keys = {
      { "<leader>fl", "<cmd>UrlView buffer bufnr=0<cr>", desc = "Find links" },
      { "<leader>fL", "<cmd>UrlView lazy<cr>", desc = "Find plugin links" },
    },
  },
  { "rafcamlet/nvim-luapad", cmd = { "Luapad", "Luarun" } },
  { "nanotee/zoxide.vim", cmd = { "Z", "Lz", "Tz", "Zi", "Lzi", "Tzi" } },
  {
    "stevearc/qf_helper.nvim",
    event = "VeryLazy",
    opts = {
      quickfix = {
        default_bindings = false,
      },
      loclist = {
        default_bindings = false,
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = "junegunn/fzf",
    ft = "qf",
    opts = {
      auto_enable = true,
      auto_close = false,
      auto_resize_height = true,
      func_map = {
        pscrollup = "<c-u>",
        pscrolldown = "<c-d>",
        split = "<c-s>",
        -- fzffilter = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
        },
      },
    },
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    opts = {},
  },
}
