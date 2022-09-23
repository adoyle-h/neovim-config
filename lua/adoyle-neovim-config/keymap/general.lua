local M = { nil, disable = false, desc = 'General Keymaps' }

M.keymaps = {
	{
		'n',
		'<F1>',
		'<Esc>',
		{
			noremap = true,
			silent = true,
			desc = 'Prevent <F1> key from opening system help window. You can use ":h" to open vim help window',
		},
	},

	{ 'n', 'Q', '<NOP>', { noremap = true, silent = true, desc = 'disable Ex mode' } },

	{ 'n', 't', 'xp', { noremap = true, silent = true, desc = 'swap adjacent characters' } },

	{ 'i', 'jk', '<Esc>', { noremap = true, silent = true, desc = 'Exit from input mode' } },

	{ 'n', '<leader>sa', 'ggVG', { noremap = true, silent = true, desc = 'select all' } },

	{ 'v', '.', ':normal .<CR>', { silent = true, desc = 'enable . command in visual mode' } },

	{ 'n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'remap U to <C-r> for easier redo' } },

	{ 'n', '<M-g>', ':echo expand("%:p")<CR>', { silent = true, desc = 'show absolute file path' } },
}

return M
