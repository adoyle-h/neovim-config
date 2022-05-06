local M = {
	nil,
	desc = 'Diff Keymaps',
	disable = false,
}

function M.config()
	if not vim.fn.has('diff') then return end

	vim.cmd [[
		map ,1 :diffget LOCAL<CR>
		map ,2 :diffget REMOTE<CR>
		map ,0 :diffget BASE<CR>
	]]
end

return M
