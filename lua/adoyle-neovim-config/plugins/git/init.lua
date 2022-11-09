local M = {
	'git',
	desc = 'Git Plugins',

	deps = {
		require('adoyle-neovim-config.plugins.git.sign'),
		require 'adoyle-neovim-config.plugins.git.lazygit',
		{ 'sindrets/diffview.nvim', desc = 'Git Diff' },

		{ 'tpope/vim-fugitive', desc = 'git commands in vim' },
		require 'adoyle-neovim-config.plugins.git.blame',
		require 'adoyle-neovim-config.plugins.git.gutter',
	},
}

return M
