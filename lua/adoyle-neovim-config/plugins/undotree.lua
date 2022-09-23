local M = {
	'simnalamburt/vim-mundo',
	desc = '显示修改历史树',
	on = 'UndotreeToggle',
	disable = false,
	keymaps = { { 'n', '<space>u', ':MundoToggle<CR>' } },
}

function M.config()
	local dir = vim.fn.stdpath('data') .. '/undodir/'

	if vim.fn.has('persistent_undo') then
		vim.opt.undodir = dir
		vim.opt.undofile = true
	end

	vim.g.mundo_width = 60
	vim.g.mundo_preview_height = 15
	vim.g.mundo_right = 1
	vim.g.mundo_auto_preview = 1
end

return M
