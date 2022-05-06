local M = {
	'vasconcelloslf/vim-interestingwords',
	desc = '高亮单词',
	disable = false,
	requires = {},
}

function M.config()
	vim.g.interestingWordsTermColors = {
		'33', '4', '210', '197', '78', '154', '99', '121', '212', '38', '166',
		'123', '214', '34', '222', '116', '207', '242',
	}
	vim.g.interestingWordsRandomiseColors = 0
end

return M
