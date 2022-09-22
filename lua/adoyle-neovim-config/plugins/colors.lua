local M = { nil, desc = 'color settings', disable = false }

local config = require('adoyle-neovim-config.config').config

M.requires = {
	require('adoyle-neovim-config.themes.' .. config.theme),

	{
		'guns/xterm-color-table.vim',
		on = {
			'XtermColorTable',
			'SXtermColorTable',
			'VXtermColorTable',
			'TXtermColorTable',
			'EXtermColorTable',
			'OXtermColorTable',
		},
		desc = 'List xterm colors',
		disable = false,
	},

	require 'adoyle-neovim-config.plugins.color-inline',

	-- Do not use 'luochen1990/rainbow'. It has bug with treesitter.
}

local function configCursorLine()
	vim.opt.cursorcolumn = false
	vim.opt.cursorline = true -- highlight current line

	-- The cursor line will be invisible at neo-tree filter mode. So do not create these autocmds.
	-- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, { command = 'set cursorline' })
	-- vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, { command = 'set nocursorline' })
end

function M.config()
	configCursorLine()

	local color = config.color
	local set_hl = vim.api.nvim_set_hl

	-- Set highlight groups
	for _, group in pairs(config.highlights) do
		for _, hl in pairs(group) do
			if type(hl) == 'function' then hl = hl(color) end
			set_hl(0, hl[1], hl[2])
		end
	end
end

return M
