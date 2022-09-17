local M = {
	'vasconcelloslf/vim-interestingwords',
	desc = 'highlight any words under cursor',
	disable = false,
	requires = {},
}

function M.config()
	local color = require('adoyle-neovim-config.config').config.color

	vim.g.interestingWordsGUIColors = color.highlightWords.gui
	vim.g.interestingWordsTermColors = color.highlightWords.cterm
	vim.g.interestingWordsRandomiseColors = 0

	vim.cmd [[
		nnoremap <silent> <leader>k :call InterestingWords('n')<CR>
		vmap <silent> <leader>k <Plug>InterestingWords
		nmap <silent> <leader>K <Plug>InterestingWordsClear
		nmap [k <Plug>InterestingWordsBackward
		nmap ]k <Plug>InterestingWordsForeward
	]]
end

return M
