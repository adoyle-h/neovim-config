return {
	'match',
	desc = 'Match quotes, parenthesis, brackets, pairs etc.',

	deps = {
		require('adoyle-neovim-config.plugins.match.surround'),
		require('adoyle-neovim-config.plugins.match.autopairs'),
		require('adoyle-neovim-config.plugins.match.ts-autotag'),
		require('adoyle-neovim-config.plugins.match.matchup'),
		require('adoyle-neovim-config.plugins.match.pears'),
	},
}
