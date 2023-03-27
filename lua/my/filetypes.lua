return {
	markdown = function()
		vim.keymap.set('n', 'gh', ':Telescope heading<cr>',
			{ silent = true, desc = 'Jump to heading', buffer = true })
	end,

	qf = function()
		vim.keymap.set('n', 'q', ':q<cr>', { silent = true, buffer = true })
	end,
}
