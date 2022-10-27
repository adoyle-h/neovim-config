return {
	'markdown',

	desc = 'Markdown Plugins',
	highlights = require('adoyle-neovim-config.plugins.markdown.highlights'),

	requires = {
		{ 'sotte/presenting.vim', ['for'] = 'markdown', desc = 'presentable slides in vim' },
		require('adoyle-neovim-config.plugins.markdown.main'),
		require('adoyle-neovim-config.plugins.markdown.toc'),
		require('adoyle-neovim-config.plugins.markdown.preview'),
		require('adoyle-neovim-config.plugins.markdown.headlines'),
	},
}
