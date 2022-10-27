return {
	'telescope',

	requires = {
		require('adoyle-neovim-config.plugins.telescope.main'),
		require('adoyle-neovim-config.plugins.telescope.tab'),
		require('adoyle-neovim-config.plugins.telescope.env'),
	},

	config = function()
		local F = require('adoyle-neovim-config.framework')
		F.telescope = require('adoyle-neovim-config.telescope')
	end,

	keymaps = require('adoyle-neovim-config.plugins.telescope.keymaps'),
	highlights = require('adoyle-neovim-config.plugins.telescope.highlights'),
	telescopes = require('adoyle-neovim-config.plugins.telescope.extensions'),
}
