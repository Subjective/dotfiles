-- Don't auto comment new lines
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "*" }, command = "setlocal fo-=c fo-=r fo-=o" })

-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "text", "plaintex" },
	group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

local iterm_profile = os.getenv("ITERM_PROFILE")
if iterm_profile then
	local function set_colorscheme(colorscheme)
		return string.format('call chansend(v:stderr, "\\e]50;SetProfile=%s\\x7")', colorscheme)
	end
	vim.cmd(set_colorscheme(vim.g.colors_name))
	vim.api.nvim_create_autocmd({ "VimLeave" }, { pattern = { "*" }, command = set_colorscheme(iterm_profile) })
end
