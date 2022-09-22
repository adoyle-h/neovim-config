local M = { nil, disable = not vim.fn.has('diff'), desc = 'diff keymaps' }

M.keymaps = {
	{ 'n', '<leader>d', ':diffthis<CR>', { noremap = true, desc = 'diff this' } },
	{ 'n', '<leader>D', ':diffoff<CR>', { noremap = true, desc = 'diff off' } },
	{ 'n', ',1', ':diffget LOCAL<CR>', { noremap = true, desc = 'Diff Mode: use local code' } },
	{ 'n', ',2', ':diffget REMOTE<CR>', { noremap = true, desc = 'Diff Mode: use remote code' } },
	{ 'n', ',3', ':diffget BASE<CR>', { noremap = true, desc = 'Diff Mode: use base code' } },
}

return M
