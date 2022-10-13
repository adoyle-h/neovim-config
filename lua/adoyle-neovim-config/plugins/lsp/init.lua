return {
	'lsp',

	requires = {
		require('adoyle-neovim-config.plugins.lsp.mason'),
		require('adoyle-neovim-config.plugins.lsp.mason-installer'),
		require('adoyle-neovim-config.plugins.lsp.null-ls'),
		require('adoyle-neovim-config.plugins.lsp.preview'),
		require('adoyle-neovim-config.plugins.lsp.nlsp'),
		require('adoyle-neovim-config.plugins.lsp.fidget'),
		require('adoyle-neovim-config.plugins.lsp.format'),
		require('adoyle-neovim-config.plugins.lsp.main'),

		'williamboman/mason-lspconfig.nvim',

		{
			-- This plugin is not needed after https://github.com/neovim/neovim/pull/20198
			'antoinemadec/FixCursorHold.nvim',
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		},
	},
}
