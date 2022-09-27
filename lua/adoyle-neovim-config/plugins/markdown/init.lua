return {
	nil,
	'Markdown Plugins',
	requires = {
		require('adoyle-neovim-config.plugins.markdown.main'),
		require('adoyle-neovim-config.plugins.markdown.toc'),
		{ 'iamcco/markdown-preview.nvim', ['for'] = 'markdown', ['do'] = 'cd app & npm install' },
	},
}
