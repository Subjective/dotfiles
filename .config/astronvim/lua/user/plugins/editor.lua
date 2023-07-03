local astro_utils = require "astronvim.utils"

return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      indent_lines = false,
      keymaps = {
        insert = "<C-g>s",
        insert_line = "g<C-g>gS",
        normal = "gs",
        normal_cur = "gss",
        normal_line = "gS",
        normal_cur_line = "gSS",
        visual = "gs",
        visual_line = "gS",
        delete = "gsd",
        change = "gsr",
        change_line = "gSr",
      },
    },
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    keys = {
      { "s", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "x", "<Plug>(leap-forward-till)", mode = { "x", "o" }, desc = "Leap forward till" },
      { "X", "<Plug>(leap-backward-till)", mode = { "x", "o" }, desc = "Leap backward till" },
      { "zS", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from window" },
    },
    opts = {
      highlight_unlabeled_phase_one_targets = true,
    },
    dependencies = {
      {
        "ggandor/flit.nvim",
        opts = {
          labeled_modes = "nx",
          multiline = false,
        },
      },
      {
        "tpope/vim-repeat",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "User AstroFile",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    keys = { { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" } },
  },
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    init = function() astro_utils.set_mappings { n = { ["<leader>T"] = { name = "󰔫 Trouble" } } } end,
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
    opts = function()
      local prefix = "<leader>s"
      return {
        mapping = {
          send_to_qf = { map = prefix .. "q" },
          replace_cmd = { map = prefix .. "c" },
          show_option_menu = { map = prefix .. "o" },
          run_current_replace = { map = prefix .. "C" },
          run_replace = { map = prefix .. "R" },
          change_view_mode = { map = prefix .. "v" },
          resume_last_search = { map = prefix .. "l" },
        },
      }
    end,
    init = function() astro_utils.set_mappings { n = { ["<leader>s"] = { desc = "󰛔 Search/Replace" } } } end,
    keys = {
      { "<leader>ss", function() require("spectre").open() end, desc = "Spectre" },
      { "<leader>sf", function() require("spectre").open_file_search() end, desc = "Spectre (current file)" },
      { "<leader>sw", function() require("spectre").open_visual { select_word = true } end, desc = "Spectre (current word)" },
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
    init = function() astro_utils.set_mappings { n = { ["<leader>a"] = { desc = "󰏫 Annotate" } } } end,
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
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy Align" },
    },
  },
}
