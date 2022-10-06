local M = { 'xolox/vim-misc', requires = { 'xolox/vim-session' }, desc = 'session manage' }
local NVIM_CONF = vim.fn.stdpath('data')

M.defaultConfig = {
	'session',
	{
		directory = NVIM_CONF .. '/session',
		lock_directory = NVIM_CONF .. '/session_lock',
		autosave = 'yes',
		autoload = 'no',
	},
}

function M.config(config)
	local conf = config.session
	vim.g.session_directory = conf.directory
	vim.g.session_lock_directory = conf.lock_directory
	vim.g.session_autosave = conf.autosave
	vim.g.session_autoload = conf.autoload
end

return M
