local M = { nil, disable = false, desc = 'Emacs Editline' }

local opts = { noremap = true, silent = true }

M.keymaps = {
	{ 'i', '<C-a>', '<Esc>I', opts },
	{ 'i', '<C-e>', '<Esc>A', opts },
	{ 'i', '<C-b>', '<Esc>ha', opts },
	{ 'i', '<C-f>', '<Esc>la', opts },
	{ 'i', '<M-b>', '<Esc>bi', opts },
	{ 'i', '<M-f>', '<Esc>Ea', opts },
	{ 'i', '<M-d>', '<Esc>dwa', opts },
	{ 'i', '<C-d>', '<Esc>dla', opts },
	{ 'i', '<C-w>', '<Esc>bdei', opts },
	{ 'i', '<C-k>', '<Esc>Da', opts },
	{ 'i', '<C-u>', '<Esc>d0', opts },
}

return M
