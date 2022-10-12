local M = { 'match', desc = 'Match quotes, parenthesis, brackets, pairs etc.' }

M.requires = {
	{
		'kylechui/nvim-surround',
		desc = 'mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, tags etc.',
		config = function(config)
			require('nvim-surround').setup(config.surround)
		end,

		defaultConfig = { 'surround', {} },
	},

	{
		'steelsojka/pears.nvim',
		desc = 'Auto complete pairs. Auto remove empty pairs. Support tags.',
		config = function()
			require('pears').setup(function(conf)
				conf.preset 'tag_matching'
			end)
		end,
		defaultConfig = { 'pears', {} },
	},

	require('adoyle-neovim-config.plugins.match.matchup'),
}

return M
