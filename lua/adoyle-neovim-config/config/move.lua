return {
	accelerated = { -- :h accelerated-jk
		mode = 'time_driven',
		enable_deceleration = false,
		acceleration_limit = 200,
		acceleration_table = { 5, 10, 12, 20, 30 },
	},

	hop = {
		keys = 'asdghklqwertyuiopzxcvbnmfj',
		quit_key = '<Esc>',
		multi_windows = false,
		create_hl_autocmd = false,
	},
}
