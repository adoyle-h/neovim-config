local M = {
	'mbbill/undotree',
	desc = '修改历史树',
	on = 'UndotreeToggle',
	disable = false,
}

function M.config()
	if vim.fn.has("persistent_undo") then
		vim.api.nvim_set_option('undodir', vim.fn.stdpath('config') .. '/temp/undodir/')
		vim.api.nvim_set_option('undofile', true)
	end
end

return M
