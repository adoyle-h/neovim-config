local M = {
	'petertriho/nvim-scrollbar',
	disable = false,
}

function M.config()
	require("scrollbar").setup()
	require("scrollbar.handlers.search").setup()
	vim.cmd('hi ScrollbarHandle guibg=' .. vim.config.color.grey2)
end

return M
