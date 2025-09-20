local M = {}

--- @class fold.WinOptions
--- @field fillchars string
--- @field foldtext string
--- @field foldmethod string
--- @field foldexpr string
local FoldOptions = {}

--- @type table<integer,fold.WinOptions> each option set is win specific
local user_fold_options = {}

--- @type fold.WinOptions
local manual_mode_fold_options = {
	fillchars = (vim.o.fillchars ~= "" and vim.o.fillchars .. "," or "") .. "fold: ",
	foldtext = 'v:lua.require("fold.config").foldtext()',
	foldmethod = "manual",
	foldexpr = "0",
}

local save_user_fold_options = function()
	local winr = vim.api.nvim_get_current_win()
	user_fold_options[winr] = {
		fillchars = vim.wo[winr].fillchars,
		foldtext = vim.wo[winr].foldtext,
		foldmethod = vim.wo[winr].foldmethod,
		foldexpr = vim.wo[winr].foldexpr,
	}
end

--- @param mode "user"|"manual"
M.set_fold_options = function(mode)
	local winr = vim.api.nvim_get_current_win()
	local fo
	if mode == "user" and user_fold_options[winr] ~= nil then
		fo = user_fold_options[winr]
	elseif mode == "manual" then
		fo = manual_mode_fold_options
		save_user_fold_options()
	else
		return
	end

	vim.wo[winr].fillchars = fo.fillchars
	vim.wo[winr].foldtext = fo.foldtext
	vim.wo[winr].foldmethod = fo.foldmethod
	vim.wo[winr].foldexpr = fo.foldexpr
end

return M
