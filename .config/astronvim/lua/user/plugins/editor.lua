local utils = require "astronvim.utils"

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
    init = function() utils.set_mappings { n = { ["<leader>T"] = { name = "󰔫 Trouble" } } } end,
    keys = {
      { "<leader>Tr", "<cmd>Trouble lsp_references<cr>", desc = "References" },
      { "<leader>Tf", "<cmd>Trouble lsp_definitions<cr>", desc = "Definitions" },
      { "<leader>Td", "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>Tq", "<cmd>Trouble quickfix<cr>", desc = "QuickFix" },
      { "<leader>Tl", "<cmd>Trouble loclist<cr>", desc = "LocationList" },
      { "<leader>Tw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>Tt", "<cmd>TodoTrouble<cr>", desc = "TODOs" },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = "nvim-lua/plenary.nvim",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Set up Spectre Which-Key descriptions",
        group = vim.api.nvim_create_augroup("spectre_mapping_descriptions", { clear = true }),
        pattern = "spectre_panel",
        callback = function(event)
          -- show spectre which-key menus
          require("which-key").register(
            { t = { name = "Spectre Options", r = { name = "Replacement Engine" } }, ["<localleader>"] = "Spectre" },
            { mode = "n", buffer = event.buf }
          )
          vim.keymap.set("n", "<localleader>", function() require("which-key").show "," end, { buffer = true })
          vim.keymap.set("n", "t", function() require("which-key").show "t" end, { buffer = true })
        end,
      })

      return {
        open_cmd = "new",
        live_update = true,
        line_sep_start = "",
        line_sep = "",
        mapping = {
          send_to_qf = { map = "<localleader>q" },
          replace_cmd = { map = "<localleader>c" },
          change_view_mode = { map = "<localleader>v" },
          resume_last_search = { map = "<localleader>l" },
          show_option_menu = { map = "o" },
          run_current_replace = { map = "r" },
          run_replace = { map = "R" },
          close_spectre = { map = "q", cmd = "<cmd>lua require('spectre').close()<cr>", desc = "close spectre" },
        },
      }
    end,
    init = function() utils.set_mappings { n = { ["<leader>s"] = { desc = "󰛔 Search/Replace" } } } end,
    keys = {
      {
        "<leader>ss",
        function() require("spectre").toggle() end,
        desc = "Spectre (all files)",
      },
      {
        "<leader>sS",
        function() require("spectre").open_visual { select_word = true } end,
        desc = "Spectre WORD (all files)",
      },
      {
        "<leader>sf",
        function() require("spectre").open_file_search() end,
        desc = "Spectre (current file)",
      },
      {
        "<leader>sF",
        function() require("spectre").open_file_search { select_word = true } end,
        desc = "Spectre WORD (current file)",
      },
      {
        "<leader>s",
        ':lua require("spectre").open_visual()<cr>',
        silent = true,
        mode = "x",
        desc = "Spectre selection",
      },
    },
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
    "axieax/urlview.nvim",
    cmd = "UrlView",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = {},
    keys = {
      { "<leader>fU", "<cmd>UrlView<cr>", desc = "Find URLs" },
      { "<leader>fL", "<cmd>UrlView lazy<cr>", desc = "Find plugin URLs" },
    },
  },
}
