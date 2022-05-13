local M = {
	'rcarriga/nvim-notify',
	desc = 'An awesome notify library!',
	disable = false,
}

function M.config()
	vim.notify = require('notify')

	vim.api.nvim_create_user_command('Notify', function(opts)
		local args = opts.fargs
		vim.notify(args[1], args[2] or 'info')
	end, {
		nargs = '+',
		desc = "Send message to notification window. Usage: :Notify <message> [info|warn|error]",
	})
end

return M
