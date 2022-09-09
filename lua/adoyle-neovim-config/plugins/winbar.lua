local M = {
	'SmiteshP/nvim-navic',
	desc = 'A winbar component that uses LSP to show your current code context.',
	disable = false,
}

function M.config()
	local config = require('adoyle-neovim-config.config').global

	local icons = {}
	for k, v in pairs(config.kindSymbolMap) do
		icons[k] = v .. ' '
	end

	require('nvim-navic').setup {
		icons = icons,

		highlight = false,
		separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
	}
end

return M
