local M = {
	nil,
	desc = 'Personal utility functions and commands',
	disable = false,
	-- requires = {},
	-- ['for'] = '',
}

function M.config()
	vim.api.nvim_create_user_command('GetWinConfig', function()
		vim.notify(vim.inspect(vim.api.nvim_win_get_config(0)))
	end, {})
end

return M
