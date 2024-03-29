local wezterm = require("wezterm")
---------------------------------------------------------------
return {
	-- font = wezterm.font("Cica"),
	-- font_size = 10.0,
	font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 12,
	-- cell_width = 1.1,
	-- line_height = 1.1,
	-- font_rules = {
	-- 	{
	-- 		italic = true,
	-- 		font = wezterm.font("Cica", { italic = true }),
	-- 	},
	-- 	{
	-- 		italic = true,
	-- 		intensity = "Bold",
	-- 		font = wezterm.font("Cica", { weight = "Bold", italic = true }),
	-- 	},
	-- },
	check_for_updates = true,
	use_ime = true,
	-- ime_preedit_rendering = "System",
	use_dead_keys = false,
	warn_about_missing_glyphs = false,
	-- enable_kitty_graphics = false,
  window_decorations = "RESIZE",
	animation_fps = 1,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 0,
	-- enable_wayland = enable_wayland(),
	-- https://github.com/wez/wezterm/issues/1772
	enable_wayland = false,
	color_scheme = "tokyonight",
	color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colors/" },
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
	window_padding = {
		left = 6,
		right = 0,
		top = 6,
		bottom = 0,
	},
  use_resize_increments = true,
	use_fancy_tab_bar = false,
	exit_behavior = "CloseOnCleanExit",
	tab_bar_at_bottom = true,
	window_close_confirmation = "AlwaysPrompt",
  skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'fish',
    'tmux',
  },
}

