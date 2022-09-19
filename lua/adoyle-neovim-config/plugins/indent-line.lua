local M = { 'lukas-reineke/indent-blankline.nvim', desc = 'Show indent line', disable = false }

function M.config()
	local config = require('adoyle-neovim-config.config').config.indentLine
	local util = require('adoyle-neovim-config.util')

	vim.g.indent_blankline_char = config.line
	vim.g.indent_blankline_filetype_exclude = config.excludeFileType

	util.set_hl {
		{ 'IndentBlanklineChar', config.inactive },
		{ 'IndentBlanklineContextChar', config.active },
	}

	require('indent_blankline').setup {
		-- space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = false,
	}
end

return M
