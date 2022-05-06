local M = {
	nil,
	disable = false,
}

M.requires = {
	{
		'kevinhwang91/nvim-hlslens',
		disable = false,
		config = function()
			vim.cmd 'hi HlSearchLens guibg=#282B2D'
		end,
	},

	{
		'dyng/ctrlsf.vim',
		desc = '项目内内容搜索',
		on = {'<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF'},
	},

	{
		'thinca/vim-visualstar',
		desc = 'visual 模型下查找增强',
	},
}

return M
