local M = { 'keymap.window', desc = 'window keymaps' }

M.keymaps = {
	{ 'n', '<C-W>t', '<C-W>T', { noremap = true, desc = 'move current window to new tab' } },

	{ 'n', '<C-W><', '<C-W>1<<C-W>', { remap = true, desc = 'adjust window border to left (1 space)' } },

	{ 'n', '<C-W>>', '<C-W>1><C-W>',
   { remap = true, desc = 'adjust window border to right (1 space)' } },

	{ 'n', '<C-W>+', '<C-W>1+<C-W>', { remap = true, desc = 'increment window height (1 space)' } },
	{ 'n', '<C-W>-', '<C-W>1-<C-W>', { remap = true, desc = 'decrement window height (1 space)' } },

	{ 'n', '<C-W>H', '<C-W>5<<C-W>',
   { remap = true, desc = 'adjust window border to left (5 spaces)' } },

	{
		'n',
		'<C-W>L',
		'<C-W>5><C-W>',
		{ remap = true, desc = 'adjust window border to right (5 spaces)' },
	},

	{ 'n', '<C-W>J', '<C-W>3+<C-W>', { remap = true, desc = 'increment window height (3 spaces)' } },
	{ 'n', '<C-W>K', '<C-W>3-<C-W>', { remap = true, desc = 'decrement window height (3 spaces)' } },

	{ 'n', '<C-W><C-L>', '<C-W>L', { noremap = true, desc = 'move current buffer to right' } },
	{ 'n', '<C-W><C-H>', '<C-W>H', { noremap = true, desc = 'move current buffer to left' } },
	{ 'n', '<C-W><C-J>', '<C-W>J', { noremap = true, desc = 'move current buffer to bottom' } },
	{ 'n', '<C-W><C-K>', '<C-W>K', { noremap = true, desc = 'move current buffer to top' } },

	{ 'n', '<C-W>\\', ':new<CR>', { desc = 'create new buffer horizontally' } },
	{ 'n', '<C-W>|', ':vnew<CR>', { desc = 'create new buffer vertically' } },
	{ 'n', '<C-W>N', ':vnew<CR>', { desc = 'create new buffer vertically' } },

	{ 'n', '<C-W>o', '<C-W>w<C-W>', { remap = true, desc = 'next buffer in window' } },
	{ 'n', '<C-W>O', '<C-W>W<C-W>', { remap = true, desc = 'previous buffer in window' } },
}

return M