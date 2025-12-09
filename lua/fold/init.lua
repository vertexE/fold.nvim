local M = {}

local focus = require("fold.focus")

--- @type fold.PluginOpts
local cfg = {
	diffsrc = "mini",
}

--- opens an input, then creates folds around the matched
--- strings, supports regular expressions
M.text = focus.text

--- focus on a set of predefined words, defaults to
--- TODO:, NOTE:, FIXME:, BUG:, WARN:, INFO:
--- @param words ?table<string>
M.words = function(words)
	words = words or { "TODO:", "NOTE:", "FIXME:", "BUG:", "WARN:", "INFO:" }
	return focus.text(words)
end

--- focus on marks
M.marks = focus.marks

--- focus on lsp diagnostics, defaults to all err levels
--- @param severity ?vim.diagnostic.SeverityFilter
M.diagnostics = function(severity)
	focus.diagnostics(severity)
end

M.zen = focus.zen

M.diff = focus.diff

--- @alias fold.diffPlug "mini"|"gitsigns"

--- @class fold.PluginOpts
--- @field diffsrc ?fold.diffPlug

--- @param _cfg ?fold.PluginOpts
M.setup = function(_cfg)
	if _cfg then
		cfg = vim.tbl_deep_extend("force", cfg, _cfg)
	end
end

--- whether we currently are in focus mode
--- @return boolean
M.focused = focus.focused

return M
