return {
  {
    "ggandor/leap.nvim",
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
      "tpope/vim-repeat",
    },
  },
  {
    "ggandor/flit.nvim",
    keys = {
      { "f", mode = { "n", "x" }, desc = "Flit forward to" },
      { "F", mode = { "n", "x" }, desc = "Flit backward to" },
      { "t", mode = { "n", "x" }, desc = "Flit forward till" },
      { "T", mode = { "n", "x" }, desc = "Flit backward till" },
    },
    opts = {
      labeled_modes = "nx",
      multiline = false,
    },
    dependencies = {
      "ggandor/leap.nvim",
    },
  },
  {
    "ggandor/leap-spooky.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "ggandor/leap.nvim",
    },
  },
  {
    "ggandor/leap-ast.nvim",
    keys = {
      { "<C-s>", 'v<cmd>lua require("leap-ast").leap()<cr>', "Leap Treesitter" },
      { "<C-s>", mode = { "x", "o" }, function() require("leap-ast").leap() end, "Leap Treesitter" },
    },
    dependencies = {
      "ggandor/leap.nvim",
    },
  },
}
