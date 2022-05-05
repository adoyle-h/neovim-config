local M = {
	'vim-scripts/ShowTrailingWhitespace'  ,
	desc = '高亮尾空格',
	disable = false,
}

function M.config()
	vim.cmd 'hi ShowTrailingWhitespace ctermbg=1 guibg=Grey'
end

return M
