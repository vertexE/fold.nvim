local M = {}

local lists = require("fold.lists")

--- @param words table<string>
--- @return table<integer>
M.buffer = function(words)
	local positions = {}
	for _, word in ipairs(words) do
		local success = pcall(vim.api.nvim_exec2, string.format("vimgrep /%s/ %%", word), { output = false })
		if success then
			local entries = vim.fn.getqflist()
			local lines = vim.tbl_map(function(entry)
				return entry.lnum
			end, entries)
			positions = lists.merge(positions, lines)
			vim.fn.setqflist({}, "f")
		end
	end
	return positions
end

return M
