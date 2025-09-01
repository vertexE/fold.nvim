local M = {}

local focus = require("fold.focus")
-- local manual = require("fold.search.manual")

-- TODO: these need to be reworked
--- focus on manually added user selected ranges
-- M.focus_user_ranges = focus.user_ranges
--- add a visual selection, or the current line
-- M.add_selection = manual.add_user_range
--- remove the visual selection/current line from focus
-- M.delete_selection = manual.remove_user_range

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

--- currently is a no-op, will add options gradually
M.setup = function(config) end

--- whether we currently are in focus mode
--- @return boolean
M.focused = focus.focused

return M
