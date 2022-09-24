local M = { nil, desc = 'For better writing experience', disable = false }

local config = require('adoyle-neovim-config.config').config

M.requires = {

	{
		'folke/twilight.nvim',
		config = function()
			require('twilight').setup(config.zen.twilight)
		end,
	},

	{
		'folke/zen-mode.nvim',
		config = function()
			require('zen-mode').setup(config.zen.mode)
		end,
		keymaps = { { 'n', '<space>z', ':ZenMode<CR>' } },
	},
}

return M
