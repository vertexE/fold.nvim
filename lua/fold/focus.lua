local M = {}

local manual = require("fold.search.manual")
local mdiff = require("fold.search.mini_diff")
local editor = require("fold.search.editor")
local lsp = require("fold.search.lsp")
local text = require("fold.search.text")
local config = require("fold.config")
local folding = require("fold.folding")

local state = {
	focused = false,
}

local reset = function()
	state.focused = false
	vim.cmd("normal zE")
	config.set_fold_options("user")
end

M.user_ranges = function()
	if state.focused then
		reset()
		return
	end

	local ranges = manual.ranges()
	if #ranges == 0 then
		return
	end

	config.set_fold_options("manual")
	vim.cmd("normal zE")

	local folds = folding.by_ranges(ranges)
	for _, fold in ipairs(folds) do
		vim.cmd(string.format("%d,%dfold", fold[1], fold[2]))
	end

	state.focused = true
end

--- @param s table<string>
M.text = function(s)
	if state.focused then
		reset()
		return
	end

	local matches = text.buffer(s)
	if #matches == 0 then
		vim.notify("no matches in buffer", vim.log.levels.WARN, {})
		return
	end

	config.set_fold_options("manual")
	vim.cmd("normal zE")

	local folds = folding.by_positions(matches)
	for _, fold in ipairs(folds) do
		vim.cmd(string.format("%d,%dfold", fold[1], fold[2]))
	end

	state.focused = true
end

M.marks = function()
	if state.focused then
		reset()
		return
	end

	local marks = editor.find_marks()
	if #marks == 0 then
		vim.notify("no marks found, nowhere to focus", vim.log.levels.WARN, {})
		return
	end

	editor.set_fold_options("manual")
	vim.cmd("normal zE")

	local folds = folding.by_positions(marks)
	for _, fold in ipairs(folds) do
		vim.cmd(string.format("%d,%dfold", fold[1], fold[2]))
	end

	state.focused = true
end

--- @param severity vim.diagnostic.SeverityFilter
M.diagnostics = function(severity)
	if state.focused then
		reset()
		return
	end

	local diagnostics = lsp.find_diagnostics(severity)
	if #diagnostics == 0 then
		vim.notify("no diagnostics found", vim.log.levels.WARN, {})
		return
	end

	editor.set_fold_options("manual")
	vim.cmd("normal zE")

	local folds = folding.by_positions(diagnostics)
	for _, fold in ipairs(folds) do
		vim.cmd(string.format("%d,%dfold", fold[1], fold[2]))
	end

	state.focused = true
end

M.zen = function()
	if state.focused then
		reset()
		return
	end

	local selection = editor.visual_selection()
	if #selection == 0 then
		vim.notify("no selection", vim.log.levels.WARN, {})
		return
	end

	editor.set_fold_options("manual")
	vim.cmd("normal zE")

	local folds = folding.by_ranges(selection)
	for _, fold in ipairs(folds) do
		vim.cmd(string.format("%d,%dfold", fold[1], fold[2]))
	end

	state.focused = true
end

M.diff = function()
	if state.focused then
		reset()
		return
	end

	local diffs = mdiff.diff_ranges()
	if #diffs == 0 then
		vim.notify("no diffs in current file", vim.log.levels.WARN, {})
		return
	end

	editor.set_fold_options("manual")
	vim.cmd("normal zE")

	local folds = folding.by_ranges(diffs)
	for _, fold in ipairs(folds) do
		vim.cmd(string.format("%d,%dfold", fold[1], fold[2]))
	end

	state.focused = true
end

return M
