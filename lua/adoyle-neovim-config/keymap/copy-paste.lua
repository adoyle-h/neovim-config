local M = { nil, desc = 'Copy&Paste Keymap', disable = false }

function M.config()
	local keymap = vim.keymap.set

	keymap('v', '<leader>y', '"+y', { noremap = true, desc = 'copy selected into system clipboard' })

	keymap('n', 'Y', 'y$',
		{ noremap = true, desc = 'y$ -> Y Make Y behave like other capitals: D, C etc...' })

	keymap({ 'n', 'x' }, '<leader>p', '"0p', { noremap = true, desc = 'paste from vim clipboard' })

	keymap({ 'n', 'x' }, '<leader>P', '"*p', { noremap = true, desc = 'paste from system clipboard' })

	keymap({ 'n', 'x' }, '<M-p>', ':set paste!<CR>',
		{ noremap = true, silent = false, desc = 'toggle paste mode' })
end

return M
