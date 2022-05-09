local M = {
	nil,
	desc = 'Window Keymaps',
	disable = false,
}

function M.config()
	local keymap = vim.keymap.set

	keymap('n', '<leader>w', ':w<CR>', { noremap = true, desc = 'save current buffer' })
	keymap('n', '<leader>e', ':e<CR>', { noremap = true, desc = 'refresh current window' })
	keymap('n', '<C-W>x', '<C-W>q', { noremap = true, desc = 'close buffer' })
	keymap('n', '<C-W>!', '<C-W>T', { noremap = true, desc = 'put current buffer to new tab' })

	keymap('n', '<C-W><', '<C-W><<C-W>', { remap = true, noremap = false, desc = 'adjust window border to left' })
	keymap('n', '<C-W>>', '<C-W>><C-W>', { remap = true, noremap = false, desc = 'adjust window border to right' })
	keymap('n', '<C-W>+', '<C-W>+<C-W>', { remap = true, noremap = false, desc = 'increment window height' })
	keymap('n', '<C-W>-', '<C-W>-<C-W>', { remap = true, noremap = false, desc = 'decrement window height' })

	keymap('n', '<C-W>H', '<C-W>5<<C-W>', { noremap = false, desc = 'adjust window border to left (5 spaces)' })
	keymap('n', '<C-W>L', '<C-W>5><C-W>', { noremap = false, desc = 'adjust window border to right (5 spaces)' })
	keymap('n', '<C-W>J', '<C-W>3+<C-W>', { noremap = false, desc = 'increment window height (3 spaces)' })
	keymap('n', '<C-W>K', '<C-W>3-<C-W>', { noremap = false, desc = 'decrement window height (3 spaces)' })

	keymap('n', '<C-W><C-L>', '<C-W>L', { noremap = true, desc = 'move cursor to right buffer' })
	keymap('n', '<C-W><C-H>', '<C-W>H', { noremap = true, desc = 'move cursor to left buffer' })
	keymap('n', '<C-W><C-J>', '<C-W>J', { noremap = true, desc = 'move cursor to bottom buffer' })
	keymap('n', '<C-W><C-K>', '<C-W>K', { noremap = true, desc = 'move cursor to upper buffer' })

	keymap('n', '<C-W>\\', ':new<CR>', { noremap = true, desc = 'create new buffer horizontally' })
	keymap('n', '<C-W>|', ':vnew<CR>', { noremap = true, desc = 'create new buffer vertically' })
	keymap('n', '<C-W>N', ':vnew<CR>', { noremap = true, desc = 'create new buffer vertically' })

	keymap('n', '<C-W>o', '<C-W>w<C-W>', { noremap = true, desc = '' })
	keymap('n', '<C-W>O', '<C-W>W<C-W>', { noremap = true, desc = '' })
end

return M
