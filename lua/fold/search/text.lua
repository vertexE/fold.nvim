local M = {}

local lists = require("fold.lists")

--- @param words table<string>
--- @return table<integer>
M.buffer = function(words)
	local positions = {}
	for _, word in ipairs(words) do
		vim.cmd(string.format("vimgrep /%s/ %%", word))
		local entries = vim.fn.getqflist()
		local lines = vim.tbl_map(function(entry)
			return entry.lnum
		end, entries)
		positions = lists.merge(positions, lines)
	end
	return positions
end

return M
