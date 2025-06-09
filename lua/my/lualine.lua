local M = {}

local printf = string.format

local function bufferNumber()
	return 'buf:' .. vim.api.nvim_get_current_buf()
end

local function winNumber()
	return 'win:' .. vim.api.nvim_get_current_win()
end

local function location()
	local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	local total = vim.api.nvim_buf_line_count(0)

	return printf('%s/%s %s', row, total, col)
end

local function spaces()
	return printf('ts:%s sw:%s', vim.o.tabstop, vim.o.shiftwidth)
end

local function my_sections(funcs)
	return function()
		local str = ''
		for _, func in pairs(funcs) do str = str .. ' ' .. func() end
		return str
	end
end

M.config = function()
	local ok = pcall(require, 'lualine')
	if not ok then
		return
	end

	local progress = require('lualine.components.progress')
	return {
		lualine = {
			sections = {
				lualine_x = { my_sections({ progress, location, spaces, bufferNumber, winNumber }), 'filesize' },
			},
		},
	}
end

return M
