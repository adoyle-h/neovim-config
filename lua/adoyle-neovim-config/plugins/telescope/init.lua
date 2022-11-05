return {
	'telescope',

	requires = {
		require('adoyle-neovim-config.plugins.telescope.main'),
		require('adoyle-neovim-config.plugins.telescope.tab'),

		{
			'keyvchan/telescope-find-pickers.nvim',
			desc = 'Find all pickers available (includes builtins and extensions)',
			config = function()
				require('telescope').load_extension('find_pickers')
			end,
		},

		{
			'adoyle-h/telescope-extension-maker.nvim',
			config = function()
				local F = require('adoyle-neovim-config.framework')
				F.telescope = require('telescope-extension-maker')
			end,
		},
	},

	keymaps = require('adoyle-neovim-config.plugins.telescope.keymaps'),
	highlights = require('adoyle-neovim-config.plugins.telescope.highlights'),
	telescopes = require('adoyle-neovim-config.plugins.telescope.extensions'),
}
