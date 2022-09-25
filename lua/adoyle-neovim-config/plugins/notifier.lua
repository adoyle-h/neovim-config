return {
	'vigoux/notifier.nvim',
	disable = true,
	defaultConfig = { 'notifier', {} },
	config = function()
		local config = require('adoyle-neovim-config.config').config
		require'notifier'.setup(config.notifier)
	end,
}
