return {
	'telescope',

	requires = {
		require('adoyle-neovim-config.plugins.telescope.main'),
		require('adoyle-neovim-config.plugins.telescope.emoji'),
		require('adoyle-neovim-config.plugins.telescope.tab'),
		require('adoyle-neovim-config.plugins.telescope.env'),
	},

	keymaps = require('adoyle-neovim-config.plugins.telescope.keymaps'),
	highlights = require('adoyle-neovim-config.plugins.telescope.highlights'),
	telescopes = require('adoyle-neovim-config.plugins.telescope.extensions'),
}
