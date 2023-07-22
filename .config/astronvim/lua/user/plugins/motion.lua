return {
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    keys = {
      { "s", "<Plug>(leap-forward-to)", mode = { "n" }, desc = "Leap forward to" },
      { "S", "<Plug>(leap-backward-to)", mode = { "n" }, desc = "Leap backward to" },
      { "gs", "<Plug>(leap-from-window)", mode = { "n" }, desc = "Leap from window" },
    },
    init = function() -- https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=100")
          vim.opt.guicursor:append { "a:Cursor/lCursor" }
        end,
        pattern = "LeapEnter",
      })
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=0")
          vim.opt.guicursor:remove { "a:Cursor/lCursor" }
        end,
        pattern = "LeapLeave",
      })
    end,
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
          next_group = "<space>",
          prev_group = "<tab>",
          multi_accept = "<enter>",
          multi_revert = "<backspace>",
        },
      }
    end,
  },
  {
    "ggandor/flit.nvim",
    dependencies = { "ggandor/leap.nvim" },
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
      remote_op = {
        motion = true,
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
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Flash Treesitter Search",
      },
    },
  },
}
