return {
	'lsp',

	requires = { require('adoyle-neovim-config.plugins.lsp.main') },

	deps = {
		require('adoyle-neovim-config.plugins.lsp.mason'),
		require('adoyle-neovim-config.plugins.lsp.mason-installer'),
		'williamboman/mason-lspconfig.nvim',
		require('adoyle-neovim-config.plugins.lsp.null-ls'),
		require('adoyle-neovim-config.plugins.lsp.preview'),
		require('adoyle-neovim-config.plugins.lsp.nlsp'),
		require('adoyle-neovim-config.plugins.lsp.fidget'),
		require('adoyle-neovim-config.plugins.lsp.format'),

		{
			'adoyle-h/lsp-toggle.nvim',
			config = function(config)
				require('lsp-toggle').setup(config.lsp.toggle)
			end,
			defaultConfig = { { 'lsp', 'toggle' }, {} },
		},

		{
			-- This plugin is not needed after https://github.com/neovim/neovim/pull/20198
			'antoinemadec/FixCursorHold.nvim',
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		},
	},
}
