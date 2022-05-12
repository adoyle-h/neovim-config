local M = {
	nil,
	desc = 'Search Keymaps',
	disable = false,
}

function M.config()
	local keymap = vim.keymap.set

	keymap('n', '<C-n>', '*', { noremap = true, silent = true, desc = 'search word under cursor (with "<" and ">" around the word)' })
	keymap('n', '<C-p>', '#', { noremap = true, silent = true, desc = 'reversed search word under cursor (with "<" and ">" around the word)' })

	keymap('n', 'g<C-n>', 'g*', { noremap = true, silent = true, desc = 'search word under cursor (without "<" and ">" around the word)' })
	keymap('n', 'g<C-p>', 'g#', { noremap = true, silent = true, desc = 'reversed search word under cursor (without "<" and ">" around the word)' })

	keymap('n', '<leader>C', ':let @/ = ""<CR>', { noremap = true, silent = true, desc = 'clear highlighted search' })

	keymap('n', '<leader>h', ':set hlsearch! hlsearch?<CR>', {
		noremap = true, silent = true, desc = 'toggle highlighted search',
	})
end

return M
