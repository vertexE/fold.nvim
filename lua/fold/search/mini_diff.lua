local M = {}

local OFFSET = 4

M.diff_ranges = function()
	local status, mini_diff = pcall(require, "mini.diff")
	if not status then
		vim.notify("missing mini.diff!", vim.log.levels.ERROR, {})
		return {}
	end

	local diffs = mini_diff.export("qf", { scope = "current" })

	local ranges = {}
	for _, diff in pairs(diffs) do
		table.insert(ranges, { math.max(1, diff.lnum - OFFSET), diff.end_lnum + OFFSET })
	end

	return ranges
end

return M
