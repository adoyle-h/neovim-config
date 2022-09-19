local M = { nil, desc = 'Emacs Editline Keymap', disable = false }

function M.config()
	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap.set

	keymap('i', '<C-a>', '<Esc>I', opts)
	keymap('i', '<C-e>', '<Esc>A', opts)
	keymap('i', '<C-b>', '<Esc>ha', opts)
	keymap('i', '<C-f>', '<Esc>la', opts)
	keymap('i', '<M-b>', '<Esc>bi', opts)
	keymap('i', '<M-f>', '<Esc>Ea', opts)
	keymap('i', '<M-d>', '<Esc>dwa', opts)
	keymap('i', '<C-d>', '<Esc>dla', opts)
	keymap('i', '<C-w>', '<Esc>bdei', opts)
	keymap('i', '<C-k>', '<Esc>Da', opts)
	keymap('i', '<C-u>', '<Esc>d0', opts)
end

return M
