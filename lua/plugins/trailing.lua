local M = {
	'johnfrankmorgan/whitespace.nvim',
	desc = '高亮尾空格',
	disable = false,
}

function M.config()
	vim.cmd(vim.fn.printf('hi TrailingWhitespace ctermbg=8 guibg=%s', vim.config.color.grey3))

	require('whitespace-nvim').setup({
		highlight = 'TrailingWhitespace',

		-- `ignored_filetypes` configures which filetypes to ignore when displaying trailing whitespace
		ignored_filetypes = {
			'TelescopePrompt',
			'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
			'lsp-installer',
			'null-ls-info',
		},
	})

	vim.api.nvim_create_user_command('TrailingSpaces', function()
		require('whitespace-nvim').trim()
	end, {})
end

return M
