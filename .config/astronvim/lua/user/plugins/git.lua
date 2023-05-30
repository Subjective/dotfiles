return {
  {
    "tpope/vim-fugitive",
    event = "User AstroGitFile",
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    config = function(_, opts)
      opts.use_diagnostics_signs = true
      require("octo").setup(opts)
      vim.treesitter.language.register("markdown", "octo")
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Set Up Octo Which-Key",
        group = vim.api.nvim_create_augroup("octo_settings", { clear = true }),
        pattern = "octo",
        callback = function(event)
          vim.api.nvim_buf_set_keymap(0, "i", "@", "@<C-x><C-o>", { silent = true, noremap = true })
          vim.api.nvim_buf_set_keymap(0, "i", "#", "#<C-x><C-o>", { silent = true, noremap = true })
          require("which-key").register({
            c = { name = " Comments" },
            ca = { "<cmd>Octo comment add<CR>", "Add a new comment" },
            cd = { "<cmd>Octo comment delete<CR>", "Delete a comment" },

            t = { name = "󰠢 Threads" },
            ta = { "<cmd>Octo thread resolve<CR>", "Mark thread as resolved" },
            td = { "<cmd>Octo thread unresolve<CR>", "Mark thread as unresolved" },

            i = { name = " Issues" },
            ic = { "<cmd>Octo issue close<CR>", "Close current issue" },
            ir = { "<cmd>Octo issue reopen<CR>", "Reopen current issue" },
            il = { "<cmd>Octo issue list<CR>", "List open issues" },
            iu = { "<cmd>Octo issue url<CR>", "Copies URL of current issue" },
            io = { "<cmd>Octo issue browser<CR>", "Open current issue in browser" },

            p = { name = " Pull requests" },
            pp = { "<cmd>Octo pr checkout<CR>", "Checkout PR" },
            pm = { name = "Merge current PR" },
            pmm = { "<cmd>Octo pr merge commit<CR>", "Merge commit PR" },
            pms = { "<cmd>Octo pr merge squash<CR>", "Squash merge PR" },
            pmd = { "<cmd>Octo pr merge delete<CR>", "Delete merge PR" },
            pmr = { "<cmd>Octo pr merge rebase<CR>", "Rebase merge PR" },
            pc = { "<cmd>Octo pr close<CR>", "Close current PR" },
            pn = { "<cmd>Octo pr create<CR>", "Create PR for current branch" },
            pd = { "<cmd>Octo pr diff<CR>", "Show PR diff" },
            ps = { "<cmd>Octo pr list<CR>", "List open PRs" },
            pr = { "<cmd>Octo pr ready<CR>", "Mark draft as ready for review" },
            po = { "<cmd>Octo pr browser<CR>", "Open current PR in browser" },
            pu = { "<cmd>Octo pr url<CR>", "Copies URL of current PR" },
            pt = { "<cmd>Octo pr commits<CR>", "List PR commits" },
            pl = { "<cmd>Octo pr commits<CR>", "List changed files in PR" },

            r = { name = " Repo" },
            rl = { "<cmd>Octo repo list<CR>", "List repo user stats" },
            rf = { "<cmd>Octo repo fork<CR>", "Fork repo" },
            ro = { "<cmd>Octo repo open<CR>", "Open current repo in browser" },
            ru = { "<cmd>Octo repo url<CR>", "Copies URL of current repo" },

            a = { name = " Assignee/Reviewer" },
            aa = { "<cmd> Octo assignee add<CR>", "Assign a user" },
            ar = { "<cmd> Octo assignee remove<CR>", "Remove a user" },
            ap = { "<cmd> Octo reviewer add<CR>", "Assign a PR reviewer" },

            l = { name = " Label" },
            la = { "<cmd> Octo label add<CR>", "Assign a label" },
            lr = { "<cmd> Octo label remove<CR>", "Remove a label" },
            lc = { "<cmd> Octo label create<CR>", "Create a label" },

            e = { name = " Reactions" },
            e1 = { "<cmd>Octo reaction thumbs_up<CR>", "Add 👍 reaction" },
            e2 = { "<cmd>Octo reaction thumbs_down<CR>", "Add 👎 reaction" },
            e3 = { "<cmd>Octo reaction eyes<CR>", "Add 👀 reaction" },
            e4 = { "<cmd>Octo reaction laugh<CR>", "Add 😄 reaction" },
            e5 = { "<cmd>Octo reaction confused<CR>", "Add 😕 reaction" },
            e6 = { "<cmd>Octo reaction rocket<CR>", "Add 🚀 reaction" },
            e7 = { "<cmd>Octo reaction heart<CR>", "Add ❤️ reaction" },
            e8 = { "<cmd>Octo reaction party<CR>", "Add 🎉 reaction" },

            x = { "<cmd>Octo actions<CR>", "Run an action" },

            s = { name = " Review" },
            ss = { "<cmd> Octo review start<CR>", "Start review" },
            sf = { "<cmd> Octo review submit<CR>", "Submit review" },
            sr = { "<cmd> Octo review resume<CR>", "Submit resume" },
            sd = { "<cmd> Octo review discard<CR>", "Delete pending review" },
            sc = { "<cmd> Octo review comments<CR>", "View pending comments" },
            sp = { "<cmd> Octo review commit<CR>", "Select commit to review" },
            sC = { "<cmd> Octo review close<CR>", "Return to PR" },
          }, { prefix = "<localleader>", buffer = event.buf })
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    config = function()
      local actions = require "diffview.actions"
      local utils = require "astronvim.utils" --  astronvim utils

      local prefix = "<leader>D"

      utils.set_mappings {
        n = {
          [prefix] = { name = " Diff View" },
          [prefix .. "<cr>"] = { "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
          [prefix .. "h"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "Open DiffView File History" },
          [prefix .. "H"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Open DiffView Branch History" },
        },
      }

      local build_keymaps = function(maps)
        local out = {}
        local i = 1
        for lhs, def in
          pairs(utils.extend_tbl(maps, {
            [prefix .. "q"] = { "<cmd>DiffviewClose<cr>", desc = "Quit Diffview" }, -- Toggle the file panel.
            ["]D"] = { actions.select_next_entry, desc = "Next Difference" }, -- Open the diff for the next file
            ["[D"] = { actions.select_prev_entry, desc = "Previous Difference" }, -- Open the diff for the previous file
            ["[C"] = { actions.prev_conflict, desc = "Next Conflict" }, -- In the merge_tool: jump to the previous conflict
            ["]C"] = { actions.next_conflict, desc = "Previous Conflict" }, -- In the merge_tool: jump to the next conflict
            ["Cl"] = { actions.cycle_layout, desc = "Cycle Diff Layout" }, -- Cycle through available layouts.
            ["Ct"] = { actions.listing_style, desc = "Cycle Tree Style" }, -- Cycle through available layouts.
            ["<leader>e"] = { actions.toggle_files, desc = "Toggle Explorer" }, -- Toggle the file panel.
            ["<leader>o"] = { actions.focus_files, desc = "Focus Explorer" }, -- Bring focus to the file panel
          }))
        do
          local opts
          local rhs = def
          local mode = { "n" }
          if type(def) == "table" then
            if def.mode then mode = def.mode end
            rhs = def[1]
            def[1] = nil
            def.mode = nil
            opts = def
          end
          out[i] = { mode, lhs, rhs, opts }
          i = i + 1
        end
        return out
      end

      require("diffview").setup {
        view = {
          merge_tool = { layout = "diff3_mixed" },
        },
        keymaps = {
          disable_defaults = true,
          view = build_keymaps {
            [prefix .. "o"] = { actions.conflict_choose "ours", desc = "Take Ours" }, -- Choose the OURS version of a conflict
            [prefix .. "t"] = { actions.conflict_choose "theirs", desc = "Take Theirs" }, -- Choose the THEIRS version of a conflict
            [prefix .. "b"] = { actions.conflict_choose "base", desc = "Take Base" }, -- Choose the BASE version of a conflict
            [prefix .. "a"] = { actions.conflict_choose "all", desc = "Take All" }, -- Choose all the versions of a conflict
            [prefix .. "0"] = { actions.conflict_choose "none", desc = "Take None" }, -- Delete the conflict region
          },
          diff3 = build_keymaps {
            [prefix .. "O"] = { actions.diffget "ours", mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget "theirs", mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          diff4 = build_keymaps {
            [prefix .. "B"] = { actions.diffget "base", mode = { "n", "x" }, desc = "Get Base Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "O"] = { actions.diffget "ours", mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget "theirs", mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          file_panel = build_keymaps {
            j = actions.next_entry, -- Bring the cursor to the next file entry
            k = actions.prev_entry, -- Bring the cursor to the previous file entry.
            o = actions.select_entry,
            S = actions.stage_all, -- Stage all entries.
            U = actions.unstage_all, -- Unstage all entries.
            X = actions.restore_entry, -- Restore entry to the state on the left side.
            L = actions.open_commit_log, -- Open the commit log panel.
            Cf = { actions.toggle_flatten_dirs, desc = "Flatten" }, -- Flatten empty subdirectories in tree listing style.
            R = actions.refresh_files, -- Update stats and entries in the file list.
            ["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"] = actions.scroll_view(-0.25), -- Scroll the view up
            ["<c-f>"] = actions.scroll_view(0.25), -- Scroll the view down
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          file_history_panel = build_keymaps {
            j = actions.next_entry,
            k = actions.prev_entry,
            o = actions.select_entry,
            y = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
            L = actions.open_commit_log,
            zR = { actions.open_all_folds, desc = "Open all folds" },
            zM = { actions.close_all_folds, desc = "Close all folds" },
            ["?"] = { actions.options, desc = "Options" }, -- Open the option panel
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          option_panel = {
            q = actions.close,
            o = actions.select_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse"] = actions.select_entry,
          },
        },
      }
    end,
  },
}
