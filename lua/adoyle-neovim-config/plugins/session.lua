local M = {
	'xolox/vim-misc',
	requires = { 'xolox/vim-session' },
	desc = '会话管理',
}

function M.config()
	local NVIM_CONF = vim.fn.stdpath('data')
	vim.g.session_directory = NVIM_CONF .. '/session'
	vim.g.session_lock_directory = NVIM_CONF .. '/session_lock'
	vim.g.session_autosave = 'yes'
	vim.g.session_autoload = 'no'
end

return M
