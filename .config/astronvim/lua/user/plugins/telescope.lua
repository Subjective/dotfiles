local utils = require "astronvim.utils"

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-file-browser.nvim",
      keys = { { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File explorer" } },
    },
    {
      "debugloop/telescope-undo.nvim",
      keys = { { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Find in undo history" } },
    },
    {
      "jay-babu/project.nvim",
      name = "project-nvim",
      event = "VeryLazy",
      opts = {
        patterns = { "lua" },
        ignore_lsp = { "lua_ls", "null-ls", "texlab" },
      },
      keys = { { "<leader>fp", function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" } },
    },
    {
      "AckslD/nvim-neoclip.lua",
      event = { "TextYankPost", "RecordingEnter" },
      opts = {},
      keys = {
        { "<leader>fy", "<cmd>Telescope neoclip<cr>", desc = "Find yank history" },
        { "<leader>fq", function() require("telescope").extensions.macroscope.default() end, desc = "Find macro history" },
      },
    },
  },
  cmd = "Telescope",
  opts = function(_, opts)
    local actions = require "telescope.actions"
    local fb_actions = require("telescope").extensions.file_browser.actions

    actions.select = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        require("telescope.actions").close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then vim.cmd(string.format("%s %s", "edit", j.path)) end
        end
      else
        require("telescope.actions").select_default(prompt_bufnr)
      end
    end

    return require("astronvim.utils").extend_tbl(opts, {
      defaults = {
        selection_caret = "  ",
        mappings = {
          i = {
            ["<c-x>"] = false,
            ["<c-s>"] = "select_horizontal",
            ["<cr>"] = "select",
          },
          n = {
            ["<c-x>"] = false,
            ["<c-s>"] = "select_horizontal",
            ["<cr>"] = "select",
          },
        },
      },
      extensions = {
        file_browser = {
          mappings = {
            i = {
              ["<C-z>"] = fb_actions.toggle_hidden,
            },
            n = {
              z = fb_actions.toggle_hidden,
            },
          },
        },
      },
      pickers = {
        buffers = {
          path_display = { "smart" },
          mappings = {
            i = { ["<c-x>"] = actions.delete_buffer },
            n = { ["x"] = actions.delete_buffer },
          },
        },
      },
      undo = {
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
      },
    })
  end,
  config = function(...)
    require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "file_browser"
    telescope.load_extension "undo"
    telescope.load_extension "projects"
    telescope.load_extension "neoclip"
  end,
  init = function() utils.set_mappings { x = { ["<leader>g"] = { name = utils.get_icon("Git", 1, true) .. "Git" } } } end,
  keys = {
    {
      "<leader>gc",
      function() require("telescope.builtin").git_bcommits_range { use_file_path = true } end,
      mode = "x",
      desc = "Git commmits (selected range)",
    },
    {
      "<leader>f.",
      function()
        require("telescope.builtin").find_files {
          cwd = vim.env.HOME,
          find_command = {
            "git",
            "--git-dir",
            vim.env.HOME .. "/.cfg/",
            "--work-tree",
            vim.env.HOME,
            "ls-tree",
            "--full-tree",
            "-r",
            "--name-only",
            "HEAD",
          },
        }
      end,
      desc = "Find dotfiles",
    },
  },
}
