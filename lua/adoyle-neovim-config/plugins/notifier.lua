return {
	'vigoux/notifier.nvim',
	disable = true,
	defaultConfig = { 'notifier', {} },
	config = function(config)
		require'notifier'.setup(config.notifier)
	end,
}
