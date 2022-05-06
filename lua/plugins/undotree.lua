local M = {
	'mbbill/undotree',
	desc = '修改历史树',
	on = 'UndotreeToggle',
	disable = false,
}

function M.config()
	local dir = vim.fn.stdpath('config') .. '/temp/undodir/'

	if vim.fn.has("persistent_undo") then
		vim.o.undodir = dir
		vim.api.nvim_set_option('undofile', true)
	end

	vim.cmd [[
		noremap <leader>ud :UndotreeToggle<CR>
		noremap <space>u :UndotreeToggle<CR>
	]]
end

return M
