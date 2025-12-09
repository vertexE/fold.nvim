local M = {}

local OFFSET = 4

--- @return table<table<integer,integer>>
local mini_diff = function()
	local stat_load, mini_diff = pcall(require, "mini.diff")
	if not stat_load then
		vim.notify("fold: missing mini.diff!", vim.log.levels.ERROR, {})
		return {}
	end

	local stat_export, diffs = pcall(mini_diff.export, "qf", { scope = "current" })
	if not stat_export then
		vim.notify("fold: mini.diff not setup!", vim.log.levels.ERROR, {})
		return {}
	end

	local ranges = {}
	for _, diff in pairs(diffs) do
		table.insert(ranges, { math.max(1, diff.lnum - OFFSET), diff.end_lnum + OFFSET })
	end

	return ranges
end

--- @return table<table<integer,integer>>
local gitsigns_diff = function()
	local stat_load, gitsigns = pcall(require, "gitsigns")
	if not stat_load then
		vim.notify("missing gitsigns!", vim.log.levels.ERROR, {})
		return {}
	end

	local stat_hunks, hunks = pcall(gitsigns.get_hunks)
	if not stat_hunks then
		vim.notify("fold: gitsigns not setup!", vim.log.levels.ERROR, {})
		return {}
	end

	if not hunks then
		return {}
	end

	--- @class fold.gitsigns.delta
	--- @field start integer 1-based line number
	--- @field count integer line count

	local ranges = {}
	for _, hunk in ipairs(hunks) do
		--- @type fold.gitsigns.delta
		local rmved = hunk["removed"]
		--- @type fold.gitsigns.delta
		local added = hunk["added"]

		local start_ln = math.min(rmved.start, added.start)
		local end_ln = math.max(rmved.start, added.start + added.count - 1)

		table.insert(ranges, { math.max(1, start_ln - OFFSET), end_ln + OFFSET })
	end

	return ranges
end

--- calculates diff chunks, following 1 based line indexing
--- @param diffsrc fold.diffPlug
--- @return table<table<integer,integer>>
M.diff_ranges = function(diffsrc)
	if diffsrc == "mini" then
		return mini_diff()
	elseif diffsrc == "gitsigns" then
		return gitsigns_diff()
	end

	vim.notify("fold: unsupported diff src", vim.log.levels.ERROR)
	return {}
end

return M
