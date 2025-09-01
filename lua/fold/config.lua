local M = {}

--- @class fold.FoldOptions
--- @field foldminlines integer
--- @field fillchars string
--- @field foldtext string
--- @field foldmethod string
local FoldOptions = {}

--- @type fold.FoldOptions | nil
local user_fold_options = nil
--- @type fold.FoldOptions
local manual_mode_fold_options = {
	foldminlines = 0,
	fillchars = (vim.o.fillchars ~= "" and vim.o.fillchars .. "," or "") .. "fold: ",
	foldtext = string.rep("∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙", 30),
	foldmethod = "manual",
}

local save_user_fold_options = function()
	user_fold_options = {
		foldminlines = vim.wo.foldminlines,
		fillchars = vim.wo.fillchars,
		foldtext = vim.wo.foldtext,
		foldmethod = vim.wo.foldmethod,
	}
end

--- @param mode "user"|"manual"
M.set_fold_options = function(mode)
	local winr = vim.api.nvim_get_current_win()
	local fo
	if mode == "user" and user_fold_options ~= nil then
		fo = user_fold_options
	elseif mode == "manual" then
		fo = manual_mode_fold_options
		save_user_fold_options()
	else
		return
	end

	vim.wo[winr].foldminlines = fo.foldminlines
	vim.wo[winr].fillchars = fo.fillchars
	vim.wo[winr].foldtext = fo.foldtext
	vim.wo[winr].foldmethod = fo.foldmethod
end

return M
