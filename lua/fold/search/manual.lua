local M = {}

local ranges = {}

M.ranges = function()
	return ranges
end

local editor = require("fold.search.editor")

M.add_user_range = function()
	local selection = editor.visual_selection()
	table.insert(ranges, selection[1])
	vim.notify("added selection", vim.log.levels.INFO, {})
end

M.remove_user_range = function()
	local cursor_pos = vim.fn.getpos(".")
	local cursor_line = cursor_pos[2]
	for i, range in ipairs(ranges) do
		if cursor_line >= range[1] and cursor_line <= range[2] then
			table.remove(ranges, i)
			vim.notify("removed selection", vim.log.levels.INFO, {})
			return
		end
	end

	vim.notify("not an active selection", vim.log.levels.WARN, {})
end

return M
