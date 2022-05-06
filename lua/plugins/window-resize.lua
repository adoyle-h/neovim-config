local M = {
	nil,
	desc = 'Resize window layout',
	disable = false,

	requires = {
		{
			'szw/vim-maximizer',
			desc = 'window 缩放',
			disable = false,
			config = function()
				vim.g.maximizer_set_default_mapping = 0
				vim.cmd 'noremap <silent> <C-W>z :MaximizerToggle!<CR>'
			end
		},

		{
			'simeji/winresizer',
			disable = false,
			config = function()
				vim.g.winresizer_vert_resize = 5
				vim.g.winresizer_horiz_resize = 3
				vim.g.winresizer_start_key = '<C-W><C-W>'
			end
		},
	},
}

return M
