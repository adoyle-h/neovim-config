local M = { nil, desc = 'General Keymaps' }

M.keymaps = {
	{ 'n', '<F1>', ':h<CR>', { noremap = true, silent = true, desc = 'Open vim help document' } },

	{ 'n', 'Q', '<NOP>', { noremap = true, silent = true, desc = 'disable Ex mode' } },

	{ 'n', 't', 'xp', { noremap = true, silent = true, desc = 'swap adjacent characters' } },

	{ 'n', '<leader>sa', 'ggVG', { noremap = true, silent = true, desc = 'select all' } },

	{ 'v', '.', ':normal .<CR>', { silent = true, desc = 'enable . command in visual mode' } },

	{ 'n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'remap U to <C-r> for easier redo' } },

	{ 'n', '<M-g>', ':echo expand("%:p")<CR>', { silent = true, desc = 'show absolute file path' } },
}

return M
