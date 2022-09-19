local M = { nil, desc = 'Insert spaces or newline Keymap', disable = false }

function M.config()
	local keymap = vim.keymap.set

	keymap('n', '<space><space>', 'a<space><esc>',
		{ noremap = true, silent = true, desc = 'insert a space at right position of cursor' })

	keymap('n', ']<space>', 'a<space><esc>',
		{ noremap = true, silent = true, desc = 'insert a space at right position of cursor' })

	keymap('n', '[<space>', 'i<space><esc>',
		{ noremap = true, silent = true, desc = 'insert a space at left position of cursor' })

	keymap('n', '<C-k>', ':put! =\'\'<CR>j',
		{ noremap = true, silent = true, desc = 'add a blank line before current line' })

	keymap('n', '<C-j>', ':put =\'\'<CR>k',
		{ noremap = true, silent = true, desc = 'add a blank line after current line' })

	keymap('n', 'K', 'i<Enter><Esc>',
		{ noremap = true, silent = true, desc = 'split line from current cursor position' })
end

return M
