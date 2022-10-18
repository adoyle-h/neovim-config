local config = require('adoyle-neovim-config.config').config
local colors = config.colors

return {
	TelescopeResultsBorder = { fg = colors.white, bg = 'none' },
	TelescopePreviewBorder = { fg = colors.white, bg = 'none' },
	TelescopePromptBorder = { fg = colors.white, bg = 'none' },
	TelescopeBorder = { fg = colors.blue, bg = 'none' },
	TelescopePromptPrefix = { fg = colors.blue, bg = 'none' },
	TelescopeSelection = { fg = 'none', bg = colors.darkBlue },
	TelescopeSelectionCaret = { fg = colors.blue, bg = 'none' },
	TelescopeMatching = { fg = colors.orange, bg = 'none', underline = true },
}
