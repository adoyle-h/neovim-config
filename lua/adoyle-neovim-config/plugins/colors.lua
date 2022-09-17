local M = {
	nil,
	desc = 'color settings',
	disable = false,
}

local util = require('adoyle-neovim-config.util')
local config = require('adoyle-neovim-config.config').config
local color = config.color

M.requires = {
	require('adoyle-neovim-config.themes.' .. config.theme),

	{
		'guns/xterm-color-table.vim',
		on = { 'XtermColorTable', 'SXtermColorTable', 'VXtermColorTable', 'TXtermColorTable', 'EXtermColorTable',
			'OXtermColorTable' },
		desc = 'List xterm colors',
		disable = false,
	},

	require 'adoyle-neovim-config.plugins.color-inline',

	-- Do not use 'luochen1990/rainbow'. It has bug with treesitter.
}

local function configCursorLine()
	vim.opt.cursorcolumn = false
	vim.opt.cursorline = true -- highlight current line

	vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, { command = 'set cursorline' })
	vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, { command = 'set nocursorline' })

	util.set_hl {
		{ 'CursorLine', { bg = color.cursorLineBG } },
		{ 'CursorLineNr', { bg = color.cursorLineBG, fg = color.cursorLineNrFG } },
	}
end

function M.config()
	configCursorLine()

	local set_hl = vim.api.nvim_set_hl
	-- set highlight groups
	for _, hi in pairs(config.highlights) do
		if type(hi) == 'function' then hi = hi(color) end
		set_hl(0, hi[1], hi[2])
	end
end

return M
