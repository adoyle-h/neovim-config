local M = {}
M.callbacks = {
	markdown = function()
		vim.keymap.set('n', 'gh', ':Telescope heading<cr>',
			{ silent = true, desc = 'Jump to heading', buffer = true })
	end,

	qf = function()
		vim.keymap.set('n', 'q', ':q<cr>', { silent = true, buffer = true })
	end,
}

M.ft = {
	-- see :h vim.filetype.add

	-- Set the filetype based on file extension
	extension = {
		-- *.cocoascript files set filetype javascript
		cocoascript = 'javascript',
		bats = 'sh',
		overlay = 'dts', -- for zephyr shield
	},

	-- Set the filetype based on filename
	filename = { bash_profile = 'sh', profile = 'sh' },

	pattern = {
		-- Set the filetype of any full filename matching the regex to gitconfig
		['.*git/config'] = 'gitconfig',
		['Dockerfile*'] = 'dockerfile',
		['*.dockerfile'] = 'dockerfile',
	},

};

return M
