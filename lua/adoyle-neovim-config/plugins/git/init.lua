local M = {
	nil,
	desc = 'Git Plugins',

	requires = {
		require('adoyle-neovim-config.plugins.git.sign'),

		{ 'sindrets/diffview.nvim', desc = 'Git Diff' },

		{ 'tpope/vim-fugitive', desc = 'git 命令 in vim' },
		require 'adoyle-neovim-config.plugins.git.blame',
		require 'adoyle-neovim-config.plugins.git.gutter',
	},
}

return M
