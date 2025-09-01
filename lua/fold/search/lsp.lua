local M = {}

--- finds all buffer local diagnostics, points
--- @param severity ?vim.diagnostic.SeverityFilter
--- @return table<integer>
M.find_diagnostics = function(severity)
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = vim.diagnostic.get(bufnr, { severity = severity })

	if #diagnostics == 0 then
		return {}
	end

	local positions = vim.tbl_map(function(diagnostic)
		return diagnostic.lnum + 1
	end, diagnostics)

	return positions
end

return M
