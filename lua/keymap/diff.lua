local M = {
	nil,
	desc = 'Diff Keymaps',
	disable = false,
}

function M.config()
	if not vim.fn.has('diff') then return end

	local keymap = vim.keymap.set

	keymap('n', ',1', ':diffget LOCAL<CR>', { noremap = true, desc = 'Diff Mode: use local code' })
	keymap('n', ',2', ':diffget REMOTE<CR>', { noremap = true, desc = 'Diff Mode: use remote code' })
	keymap('n', ',3', ':diffget BASE<CR>', { noremap = true, desc = 'Diff Mode: use base code' })
end

return M
