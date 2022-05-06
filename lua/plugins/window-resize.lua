local M = {
	'',
	desc = 'Resize vim window',
	disable = false,

	requires = {
		{
			'szw/vim-maximizer',
			desc = 'window 缩放',
			disable = false,
			config = function()
				vim.g.maximizer_set_default_mapping = 0
			end
		},

		{'simeji/winresizer', disable = false},
	},
}

return M
