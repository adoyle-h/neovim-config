return {
	'session',
	requires = {
		require('adoyle-neovim-config.plugins.session.persisted'),

		{
			'chrisbra/Recover.vim',
			desc = 'Show difference between the hidden swap file and the regular saved file. Very useful.',
		},
	},
}
