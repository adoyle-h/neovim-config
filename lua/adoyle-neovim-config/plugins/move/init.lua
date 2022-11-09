local M = { 'move', desc = 'Plugins for fast cursor moving' }

M.deps = {
	require('adoyle-neovim-config.plugins.move.jump'),
	-- require('adoyle-neovim-config.plugins.move.choose-window'),
	-- require('adoyle-neovim-config.plugins.move.window-selector'),
	require('adoyle-neovim-config.plugins.move.window-picker'),
	require('adoyle-neovim-config.plugins.move.caml-case'),
	require('adoyle-neovim-config.plugins.move.accelerated'),
	require('adoyle-neovim-config.plugins.move.line'),
	require('adoyle-neovim-config.plugins.move.climber'),
	require('adoyle-neovim-config.plugins.move.vim-move'),
}

return M
