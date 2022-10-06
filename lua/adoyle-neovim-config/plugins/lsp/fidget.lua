return {
	'j-hui/fidget.nvim',
	desc = 'nvim-lsp loading progress',
	defaultConfig = { { 'lsp', 'fidget' }, {} },
	config = function(config)
		require('fidget').setup(config.lsp.fidget)
	end,
}
