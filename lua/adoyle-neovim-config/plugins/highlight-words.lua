local M = {
	'vasconcelloslf/vim-interestingwords',
	desc = 'highlight any words under cursor',
	disable = false,
	requires = {},
	keymaps = {
		{ 'n', '<leader>k', ':call InterestingWords("n")<CR>', { silent = true } },
		{ 'v', '<leader>k', '<Plug>InterestingWords', { silent = true } },
		{ 'n', '<leader>K', '<Plug>InterestingWordsClear', { silent = true } },
		{ 'n', '[k', '<Plug>InterestingWordsBackward', { silent = true } },
		{ 'n', ']k', '<Plug>InterestingWordsForeward', { silent = true } },
	},
}

function M.config()
	local color = require('adoyle-neovim-config.config').config.color

	vim.g.interestingWordsGUIColors = color.highlightWords.gui
	vim.g.interestingWordsTermColors = color.highlightWords.cterm
	vim.g.interestingWordsRandomiseColors = 0
end

return M
