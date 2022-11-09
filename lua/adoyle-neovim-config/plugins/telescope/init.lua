return {
	'telescope',

	requires = { require('adoyle-neovim-config.plugins.telescope.main') },

	deps = {
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

		{
			'adoyle-h/ad-telescope-extensions.nvim',

			keymaps = { { 'n', '<C-w><C-w>', ':Telescope windows<cr>', { silent = true } } },

			config = function(config)
				local util = require('adoyle-neovim-config.util')

				require('ad-telescope-extensions').setup {
					enable = 'all',
					windows = {
						excludeFileTypes = config.ignore.fileTypesForSomePlugs,
						tab = function(props)
							return 'Tab ' .. props.tab .. util.superNum(#props.wins)
						end,
					},
				}
			end,
		},

		{
			'crispgm/telescope-heading.nvim',
			config = function()
				require('telescope').load_extension('heading')
			end,
		},
	},

	keymaps = require('adoyle-neovim-config.plugins.telescope.keymaps'),
	highlights = require('adoyle-neovim-config.plugins.telescope.highlights'),
	telescopes = require('adoyle-neovim-config.plugins.telescope.extensions'),
}
