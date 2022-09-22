local M = { nil, disable = false, desc = 'Insert spaces or newline Keymap' }

M.keymaps = {

	{
		'n',
		'<space><space>',
		'a<space><esc>',
		{ noremap = true, silent = true, desc = 'insert a space at right position of cursor' },
	},

	{
		'n',
		']<space>',
		'a<space><esc>',
		{ noremap = true, silent = true, desc = 'insert a space at right position of cursor' },
	},

	{
		'n',
		'[<space>',
		'i<space><esc>',
		{ noremap = true, silent = true, desc = 'insert a space at left position of cursor' },
	},

	{
		'n',
		'<C-k>',
		':put! =\'\'<CR>j',
		{ noremap = true, silent = true, desc = 'add a blank line before current line' },
	},

	{
		'n',
		'<C-j>',
		':put =\'\'<CR>k',
		{ noremap = true, silent = true, desc = 'add a blank line after current line' },
	},

	{
		'n',
		'K',
		'i<Enter><Esc>',
		{ noremap = true, silent = true, desc = 'split line from current cursor position' },
	},

}

return M
