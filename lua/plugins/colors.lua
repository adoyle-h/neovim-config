local M = {
	'',
	desc = 'color settings',
	disable = false,
	-- requires = {},
	-- ['for'] = '',
}

M.requires = {
	{
		'guns/xterm-color-table.vim',
		on = {'XtermColorTable', 'SXtermColorTable', 'VXtermColorTable', 'TXtermColorTable', 'EXtermColorTable', 'OXtermColorTable'},
		desc = '终端颜色表',
		disable = false,
	},

	require 'plugins.color-theme',
	require 'plugins.color-inline',
}

return M
