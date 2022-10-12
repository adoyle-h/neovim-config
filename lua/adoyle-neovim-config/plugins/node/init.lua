return {
	'node',
	requires = {
		{
			'nvim-telescope/telescope-node-modules.nvim',
			config = function()
				require'telescope'.load_extension 'node_modules'
			end,
		},
	},
}
