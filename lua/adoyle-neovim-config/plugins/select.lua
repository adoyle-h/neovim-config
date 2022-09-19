local M = { nil, desc = 'The fast cursor selection', disable = false }

M.requires = {
	{
		'gcmt/wildfire.vim',
		desc = '在 normal 模式下快速选中括号内文字。可增量扩充或反选',
		config = function()
			vim.cmd [[
			" This selects the next closest text object.
			map <leader>v <Plug>(wildfire-fuel)

			" This selects the previous closest text object.
			vmap <leader>V <Plug>(wildfire-water)
			]]
		end,
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
