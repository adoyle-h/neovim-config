local config = require('adoyle-neovim-config.config').config

local M = {
	'johnfrankmorgan/whitespace.nvim',
	desc = 'highlight trailing spaces',

	highlights = { { 'TrailingWhitespace', { bg = config.color.grey3 } } },

	commands = {
		{
			'TrailingSpaces',
			function()
				require('whitespace-nvim').trim()
			end,
			{ desc = 'Remove trailing spaces' },
		},
	},

	defaultConfig = {
		'whitespace',
		{
			highlight = 'TrailingWhitespace',

			-- `ignored_filetypes` configures which filetypes to ignore when displaying trailing whitespace
			ignored_filetypes = config.ignore.fileTypesForSomePlugs,
		},
	},

	config = function()
		require('whitespace-nvim').setup(config.whitespace)
	end,
}

return M
