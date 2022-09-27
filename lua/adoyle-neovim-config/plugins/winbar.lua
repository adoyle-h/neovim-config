local config = require('adoyle-neovim-config.config').config

local M = {
	'SmiteshP/nvim-navic',
	desc = 'A winbar component that uses LSP to show your current code context.',
	disable = not config.codeContext.winbar,
}

local icons = {}
for k, v in pairs(config.kindSymbolMap) do icons[k] = v .. ' ' end

M.defaultConfig = {
	'winbar',
	{
		icons = icons,

		highlight = false,
		separator = ' > ',
		depth_limit = 0,
		depth_limit_indicator = '..',
	},
}

function M.config()
	-- silence warning/error messages thrown by nvim-navic
	vim.g.navic_silence = true

	require('nvim-navic').setup(config.winbar)
end

return M
