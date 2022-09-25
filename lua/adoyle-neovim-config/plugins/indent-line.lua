local config = require('adoyle-neovim-config.config').config
local color = config.color

local M = {
	'lukas-reineke/indent-blankline.nvim',
	desc = 'Show indent line',
	highlights = {
		{ 'IndentBlanklineChar', { fg = color.grey1 } },
		{ 'IndentBlanklineContextChar', { fg = color.purple } },
	},
}

M.defaultConfig = {
	'indentLine',
	{
		line = '⎜', -- '┊', '', '⎸', '│', '⎜', '⎜', '⎜'
		excludeFileType = {
			'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
		},
		opts = { -- :h indent_blankline
			-- space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = false,
		},
	},
}

function M.config()
	local conf = config.indentLine

	vim.g.indent_blankline_char = conf.line
	vim.g.indent_blankline_filetype_exclude = conf.excludeFileType

	require('indent_blankline').setup(conf.opts)
end

return M
