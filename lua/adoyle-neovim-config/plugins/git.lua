local M = {
	nil,
	desc = 'Git Plugins',
	disable = false,

	requires = {
		require 'adoyle-neovim-config.plugins.git.sign',

		{ 'sindrets/diffview.nvim', desc = 'Git Diff', disable = false },

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

		-- disabled plugins
		{ 'tpope/vim-fugitive', desc = 'git 命令 in vim', disable = true },
		require 'adoyle-neovim-config.plugins.git.blame',
		require 'adoyle-neovim-config.plugins.git.gutter',
	},
}

return M
