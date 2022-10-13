local M = { 'move', desc = 'Plugins for fast cursor moving' }

M.requires = {
	require('adoyle-neovim-config.plugins.move.jump'),
	-- require('adoyle-neovim-config.plugins.move.choose-window'),
	-- require('adoyle-neovim-config.plugins.move.window-selector'),
	require('adoyle-neovim-config.plugins.move.window-picker'),
	require('adoyle-neovim-config.plugins.move.caml-case'),
	require('adoyle-neovim-config.plugins.move.accelerated'),
	require('adoyle-neovim-config.plugins.move.line'),
	require('adoyle-neovim-config.plugins.move.climber'),

	{
		'matze/vim-move',
		desc = 'Use <M-j> and <M-k> to move char/line/block under cursor',
		setup = function()
			-- Because keymaps <M-h> and <M-l> are defined in tree-climber plugin
			vim.g.move_map_keys = 0
		end,
		keymaps = {
			{ 'n', '<M-j>', '<Plug>MoveLineDown' },
			{ 'n', '<M-k>', '<Plug>MoveLineUp' },
			{ 'v', '<M-j>', '<Plug>MoveBlockDown' },
			{ 'v', '<M-k>', '<Plug>MoveBlockUp' },
		},
	},
}

return M
