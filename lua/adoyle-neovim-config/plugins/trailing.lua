local config = require('adoyle-neovim-config.config').config

return {
	'johnfrankmorgan/whitespace.nvim',
	desc = 'highlight trailing spaces',

	highlights = { TrailingWhitespace = { bg = config.colors.grey3 } },

	commands = {
		{
			'TrailingSpaces',
			function()
				require('whitespace-nvim').trim()
			end,
			{ desc = 'Remove trailing spaces' },
		},
	},

	config = function()
		require('whitespace-nvim').setup(config.whitespace)
	end,

	defaultConfig = {
		'whitespace',
		{
			highlight = 'TrailingWhitespace',

			-- `ignored_filetypes` configures which filetypes to ignore when displaying trailing whitespace
			ignored_filetypes = config.ignore.fileTypesForSomePlugs,
		},
	},
}
