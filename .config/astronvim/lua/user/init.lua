--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- A split up user configuration example can be found at: https://github.com/AstroNvim/split_user_example

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = true, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    underline = true,
    update_in_insert = false,
  },
  -- -- Extend LSP configuration
  -- lsp = {
  --
  -- 	-- Add overrides for LSP server settings, the keys are the name of the server
  -- 	config = {
  -- 		-- example for addings schemas to yamlls
  -- 		-- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
  -- 		--   settings = {
  -- 		--     yaml = {
  -- 		--       schemas = {
  -- 		--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
  -- 		--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
  -- 		--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
  -- 		--       },
  -- 		--     },
  -- 		--   },
  -- 		-- },
  -- 	},
  -- },
  -- Customize Heirline options
  heirline = {
    -- -- Customize different separators between sections
    -- separators = {
    -- 	breadcrumbs = " > ",
    -- 	tab = { "", "" },
    -- },
    -- -- Customize colors for each element each element has a `_fg` and a `_bg`
    -- colors = function(colors)
    --   colors.git_branch_fg = require("astronvim.utils").get_hlgroup "Conditional"
    --   return colors
    -- end,
    -- -- Customize attributes of highlighting in Heirline components
    -- attributes = {
    --   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
    --   git_branch = { bold = true }, -- bold the git branch statusline component
    -- },
    -- -- Customize if icons should be highlighted
    icon_highlights = {
      breadcrumbs = true, -- LSP symbols in the breadcrumbs
      file_icon = {
        winbar = false, -- Filetype icon in the winbar inactive windows
        statusline = true, -- Filetype icon in the statusline
        tabline = true, -- Filetype icon in the tabline
      },
    },
  },
}

return config
