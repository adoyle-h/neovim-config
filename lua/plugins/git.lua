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
			config = function()
				vim.g.Gitv_OpenPreviewOnLaunch = 0
				-- vim.g.Gitv_PreviewOptions = '--stat'
				vim.g.Gitv_CustomMappings = {
					let = '|',
					stat = 's',
					vstat = 's',
					head = 'H',
					delete = 'dd',
					vdelete = 'dd',
				}
			end,
		},
	},
}

return M
