local M = {
	'vasconcelloslf/vim-interestingwords',
	desc = 'highlight any words under cursor',
	disable = false,
	requires = {},
}

function M.config()
	vim.g.interestingWordsTermColors = {
		'33', '4', '210', '197', '78', '154', '99', '121', '212', '38', '166',
		'123', '214', '34', '222', '116', '207', '242',
	}
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
