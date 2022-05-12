local M = {
	'xolox/vim-misc' ,
	requires = { 'xolox/vim-session'},
	desc = '会话管理',
	disable = false,
}

function M.config()
	local NVIM_CONF=vim.fn.stdpath('config')
	vim.g.session_directory=NVIM_CONF..'/temp/session'
	vim.g.session_lock_directory=NVIM_CONF..'/temp/session_lock'
	vim.g.session_autosave='yes'
	vim.g.session_autoload='no'
end

return M
