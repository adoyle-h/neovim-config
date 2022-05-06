local M = {
	'',
	desc = 'My filetype settings',
	disable = false,
	requires = {},
}

function M.config()
	local group = vim.api.nvim_create_augroup('my_filetype_detect', {})

	vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
		pattern = {'*.cocoascript'},
		group = group,
		command = 'setfiletype javascript',
		-- @TODO use callback
	})

	vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
		pattern = {'bash_profile', 'profile'},
		group = group,
		command = 'setfiletype sh',
	})
end

return M
