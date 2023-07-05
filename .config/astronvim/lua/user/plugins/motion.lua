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
    opts = function()
      require("leap").add_repeat_mappings(";", ",", {
        relative_directions = true,
        modes = { "n", "x", "o" },
      })
      return {
        highlight_unlabeled_phase_one_targets = true,
        special_keys = {
          next_target = ";",
          prev_target = ",",
        },
      }
    end,
    dependencies = {
      "tpope/vim-repeat",
    },
  },
  {
    "ggandor/flit.nvim",
    keys = {
      { "f", mode = { "n", "x", "o" }, desc = "Flit forward to" },
      { "F", mode = { "n", "x", "o" }, desc = "Flit backward to" },
      { "t", mode = { "n", "x", "o" }, desc = "Flit forward till" },
      { "T", mode = { "n", "x", "o" }, desc = "Flit backward till" },
    },
    opts = {
      labeled_modes = "nxo",
      multiline = false,
    },
    dependencies = {
      "ggandor/leap.nvim",
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = false,
        },
      },
      prompt = {
        enabled = false,
      },
    },
    keys = {
      {
        "<c-s>",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = "o",
        function() require("flash").treesitter_search() end,
        desc = "Flash Treesitter Search",
      },
    },
  },
}
