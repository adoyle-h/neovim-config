return {
	nil,
	desc = 'Load all keymap settings',
	requires = {
		require('adoyle-neovim-config.keymap.general'),
		require('adoyle-neovim-config.keymap.tab'),
		require('adoyle-neovim-config.keymap.window'),
		require('adoyle-neovim-config.keymap.diff'),
		require('adoyle-neovim-config.keymap.editline'),
		require('adoyle-neovim-config.keymap.search'),
		require('adoyle-neovim-config.keymap.copy-paste'),
		require('adoyle-neovim-config.keymap.space'),
		require('adoyle-neovim-config.keymap.indent'),
		require('adoyle-neovim-config.keymap.toggle'),
		require('adoyle-neovim-config.keymap.jump'),
	},
}
