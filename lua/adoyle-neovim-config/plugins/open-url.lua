local M = {
	'tyru/open-browser.vim',
	on = { '<Plug>(openbrowser-smart-search)', '<Plug>(openbrowser-open)' },
	desc = 'Open url from text with browser',
	config = function()
		vim.g.netrw_nogx = 1 -- disable netrw's gx mapping
	end,

	keymaps = {
		{ 'n', 'gx', '<Plug>(openbrowser-smart-search)' },
		{ 'v', 'gx', '<Plug>(openbrowser-smart-search)' },
		{ 'n', 'gX', '<Plug>(openbrowser-open)' },
		{ 'v', 'gX', '<Plug>(openbrowser-open)' },
	},
}

return M
