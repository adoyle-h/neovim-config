return {
	'rainbowhxch/accelerated-jk.nvim',
	desc = 'accelerates j/k movement steps while j or k key is repeating',

	defaultConfig = {
		{ 'move', 'accelerated' },
		{ -- :h accelerated-jk
			mode = 'time_driven',
			enable_deceleration = false,
			acceleration_limit = 200,
			acceleration_table = { 5, 10, 12, 20, 30 },
		},
	},

	config = function(config)
		require('accelerated-jk').setup(config.move.accelerated)
	end,

	keymaps = {
		{ 'n', 'j', '<Plug>(accelerated_jk_gj)', { desc = 'move cursor down' } },
		{ 'n', 'k', '<Plug>(accelerated_jk_gk)', { desc = 'move cursor up' } },
	},
}
