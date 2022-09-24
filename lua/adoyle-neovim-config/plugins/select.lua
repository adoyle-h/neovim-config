local M = { nil, desc = 'The fast cursor selection', disable = false }

M.requires = {
	{
		'gcmt/wildfire.vim',
		desc = 'Select the text-objects',
		keymaps = {
			{ '', '<leader>v', '<Plug>(wildfire-fuel)', desc = 'select the next closest text object.' },
			{ '', '<leader>V', '<Plug>(wildfire-water)', desc = 'select the previous closest text object.' },
			{ 'n', '<leader>sv', '<Plug>(wildfire-quick-select)' },
		},
	},
}

return M
