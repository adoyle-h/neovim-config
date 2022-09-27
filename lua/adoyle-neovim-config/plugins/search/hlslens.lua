local config = require('adoyle-neovim-config.config').config
local color = config.color
local mainColor = color.orange
local bgColor = color.grey2

return {
	'kevinhwang91/nvim-hlslens',
	desc = 'Highlight search floating',

	highlights = {
		{ 'Search', { bg = 'none', fg = mainColor, underline = true } },
		{ 'IncSearch', { bg = 'none', fg = mainColor, underline = true } },
		-- 1. HlSearchLensNear: highlight the nearest virtual text
		{ 'HlSearchLensNear', { bg = bgColor, fg = mainColor } },
		-- 2. HlSearchLens: highlight virtual text except for the nearest one
		{ 'HlSearchLens', { bg = bgColor, fg = color.grey } },
		-- 3. HlSearchNear: highlight the nearest matched instance
		{ 'HlSearchNear', { bg = mainColor, fg = color.black } },
		-- 4. HlSearchFloat: highlight the nearest text for the floating window
		{ 'HlSearchFloat', { bg = bgColor, fg = mainColor } },
	},
}
