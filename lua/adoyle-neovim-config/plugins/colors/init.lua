local M = { 'colors', desc = 'color settings' }

M.requires = {
	require 'adoyle-neovim-config.plugins.colors.highlights',
	require 'adoyle-neovim-config.plugins.colors.inline',

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
	},

	-- Do not use 'luochen1990/rainbow'. It has bug with treesitter.
}

return M
