local M = {
	nil,
	desc = 'The settings of nvim embeded terminal. See :h terminal',
	disable = false,
	requires = {},
}

function M.config()
	vim.api.nvim_create_autocmd({ 'TermOpen' }, {
		pattern = { '*' },
		callback = function()
			vim.wo.number = false
			vim.wo.rnu = false
		end
		-- nested = true,
	})
end

return M
