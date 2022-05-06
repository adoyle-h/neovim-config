local M = {
	nil,
	desc = 'Load all keymap settings',
	disable = false,
	requires = {
		require('keymap.tab'),
		require('keymap.window'),
		require('keymap.diff'),
		require('keymap.editline'),
		require('keymap.search'),
		require('keymap.copy-paste'),
		require('keymap.space'),
		require('keymap.indent'),
	},
}

return M
