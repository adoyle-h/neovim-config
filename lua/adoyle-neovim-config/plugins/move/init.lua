local M = { nil, desc = 'Plugins for fast cursor moving' }

M.requires = {
	require('adoyle-neovim-config.plugins.move.jump'),
	require('adoyle-neovim-config.plugins.move.choose-window'),
	require('adoyle-neovim-config.plugins.move.window-selector'),
	require('adoyle-neovim-config.plugins.move.caml-case'),
	require('adoyle-neovim-config.plugins.move.accelerated'),
	require('adoyle-neovim-config.plugins.move.line'),
	{ 'matze/vim-move', desc = 'Use <A-h>/<A-j>/<A-k>/<A-l> to move char/line/block under cursor' },
}

return M
