local M = { nil, desc = 'The fast cursor selection', disable = false }

M.requires = {
	{
		'gcmt/wildfire.vim',
		desc = 'Select the text object',
		keymaps = {
			{ '', '<leader>v', '<Plug>(wildfire-fuel)', desc = 'select the next closest text object.' },
			{ '', '<leader>V', '<Plug>(wildfire-water)', desc = 'select the previous closest text object.' },
		},
	},

	{
		'mg979/vim-visual-multi',
		desc = '多光标选择',
		config = function()
			vim.g.VM_maps = {
				['Find Under'] = '<M-n>', -- replace C-n
				['Find Subword Under'] = '<M-n>', -- replace visual C-n
			}
		end,
	},
}

return M
