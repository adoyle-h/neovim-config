local M = {
	'',
	desc = 'Plugin Description',
	disable = false,

	requires = {
		require 'plugins.git-gutter',

		{
			'tpope/vim-fugitive',
			desc = 'git 命令 in vim',
			disable = false,
		},

		{
			'gregsexton/gitv',
			desc = 'git log in vim',
			disable = false,
		},
	},
}

return M
