local M = {
	'rcarriga/nvim-notify',
	desc = 'An awesome notify library!',
	disable = false,
}

function M.config()
	vim.notify = require('notify')
	vim.api.nvim_set_keymap('n', '<space>n', ':Telescope notify<CR>', {})
end

return M
