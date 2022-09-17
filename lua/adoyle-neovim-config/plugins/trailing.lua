local config = require('adoyle-neovim-config.config').config

local M = {
	'johnfrankmorgan/whitespace.nvim',
	desc = '高亮尾空格',
	disable = false,
}

function M.config()
	local util = require('adoyle-neovim-config.util')

	util.set_hl {
		{ 'TrailingWhitespace', { bg = config.color.grey3 } }
	}

	require('whitespace-nvim').setup({
		highlight = 'TrailingWhitespace',

		-- `ignored_filetypes` configures which filetypes to ignore when displaying trailing whitespace
		ignored_filetypes = config.ignoredFileTypesForSomePlugs,
	})

	vim.api.nvim_create_user_command('TrailingSpaces', function()
		require('whitespace-nvim').trim()
	end, {})
end

return M
