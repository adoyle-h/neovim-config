return {
	'j-hui/fidget.nvim',
	desc = 'nvim-lsp loading progress',
	defaultConfig = { { 'lsp', 'fidget' }, {} },
	config = function()
		local config = require('adoyle-neovim-config.config').config
		require('fidget').setup(config.lsp.fidget)
	end,
}
