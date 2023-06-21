local astro_utils = require "astronvim.utils"

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
      opts.mappings = {
        issue = {
          close_issue = { lhs = "<localleader>ic", desc = "close issue" },
          reopen_issue = { lhs = "<localleader>io", desc = "reopen issue" },
          list_issues = { lhs = "<localleader>il", desc = "list open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "reload issue" },
          open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
          copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
          add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
          remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
          create_label = { lhs = "<localleader>lc", desc = "create label" },
          add_label = { lhs = "<localleader>la", desc = "add label" },
          remove_label = { lhs = "<localleader>ld", desc = "remove label" },
          goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<localleader>ca", desc = "add comment" },
          delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
        },
        pull_request = {
          checkout_pr = { lhs = "<localleader>po", desc = "checkout PR" },
          merge_pr = { lhs = "<localleader>pm", desc = "merge commit PR" },
          squash_and_merge_pr = { lhs = "<localleader>psm", desc = "squash and merge PR" },
          list_commits = { lhs = "<localleader>pc", desc = "list PR commits" },
          list_changed_files = { lhs = "<localleader>pf", desc = "list PR changed files" },
          show_pr_diff = { lhs = "<localleader>pd", desc = "show PR diff" },
          add_reviewer = { lhs = "<localleader>va", desc = "add reviewer" },
          remove_reviewer = { lhs = "<localleader>vd", desc = "remove reviewer request" },
          close_issue = { lhs = "<localleader>ic", desc = "close PR" },
          reopen_issue = { lhs = "<localleader>io", desc = "reopen PR" },
          list_issues = { lhs = "<localleader>il", desc = "list open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "reload PR" },
          open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
          copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
          goto_file = { lhs = "gf", desc = "go to file" },
          add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
          remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
          create_label = { lhs = "<localleader>lc", desc = "create label" },
          add_label = { lhs = "<localleader>la", desc = "add label" },
          remove_label = { lhs = "<localleader>ld", desc = "remove label" },
          goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<localleader>ca", desc = "add comment" },
          delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
        },
        review_thread = {
          goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<localleader>ca", desc = "add comment" },
          add_suggestion = { lhs = "<localleader>sa", desc = "add suggestion" },
          delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
        },
        submit_win = {
          approve_review = { lhs = "<C-a>", desc = "approve review" },
          comment_review = { lhs = "<C-m>", desc = "comment review" },
          request_changes = { lhs = "<C-r>", desc = "request changes review" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        },
        review_diff = {
          add_review_comment = { lhs = "<localleader>ca", desc = "add a new review comment" },
          add_review_suggestion = { lhs = "<localleader>sa", desc = "add a new review suggestion" },
          focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
          next_thread = { lhs = "]t", desc = "move to next thread" },
          prev_thread = { lhs = "[t", desc = "move to previous thread" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<leader><localleader>", desc = "toggle viewer viewed state" },
          goto_file = { lhs = "gf", desc = "go to file" },
        },
        file_panel = {
          next_entry = { lhs = "j", desc = "move to next changed file" },
          prev_entry = { lhs = "k", desc = "move to previous changed file" },
          select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
          refresh_files = { lhs = "R", desc = "refresh changed files panel" },
          focus_files = { lhs = "<localleader>e", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<localleader>b", desc = "hide/show changed files panel" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<localleader><localleader>", desc = "toggle viewer viewed state" },
        },
      }
      require("octo").setup(opts)
      vim.treesitter.language.register("markdown", "octo")
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Setup Octo Which-Key mappings",
        group = vim.api.nvim_create_augroup("octo_settings", { clear = true }),
        pattern = "octo",
        callback = function(event)
          vim.api.nvim_buf_set_keymap(0, "i", "@", "@<C-x><C-o>", { silent = true, noremap = true })
          vim.api.nvim_buf_set_keymap(0, "i", "#", "#<C-x><C-o>", { silent = true, noremap = true })
          require("which-key").register({
            i = { name = " Issue" },
            p = { name = " PR" },
            a = { name = " Assignee" },
            l = { name = " Label" },
            r = { name = " React" },
            c = { name = " Comment" },
            v = { name = " Reviewer" },
            g = { name = "󱘇 Navigate" },
            [","] = { name = " All Commands" },
          }, { prefix = "<localleader>", buffer = event.buf })
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
            ro = { "<cmd>Octo repo browser<CR>", "Open current repo in browser" },
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
          }, { prefix = "<localleader><localleader>", buffer = event.buf })
        end,
      })
    end,
    init = function() astro_utils.set_mappings { n = { ["<leader>G"] = { name = " GitHub" } } } end,
    keys = {
      { "<leader>Gs", "<cmd>Octo search<cr>", desc = "Search GitHub" },
      { "<leader>Gi", "<cmd>Octo issue list<cr>", desc = "Open Issues" },
      { "<leader>GI", "<cmd>Octo issue search<cr>", desc = "Search Issues" },
      { "<leader>Gp", "<cmd>Octo pr list<cr>", desc = "Open PRs" },
      { "<leader>GP", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
      { "<leader>Gr", "<cmd>Octo repo list<cr>", desc = "Open Repository" },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    opts = function()
      local actions = require "diffview.actions"

      local prefix = "<leader>D"

      astro_utils.set_mappings {
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
          pairs(astro_utils.extend_tbl(maps, {
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

      return {
        enhanced_diff_hl = true,
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
