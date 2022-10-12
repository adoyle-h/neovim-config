return {
	'dap',
	requires = {
		require('adoyle-neovim-config.plugins.dap.dap'),
		require('adoyle-neovim-config.plugins.dap.ui'),
		{
			'nvim-telescope/telescope-dap.nvim',
			config = function()
				require('telescope').load_extension('dap')
			end,
		},
	},
}
