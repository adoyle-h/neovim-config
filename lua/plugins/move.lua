local M = {
	nil,
	desc = 'Shortcuts for fast moving',
	disable = false,
}

M.requires = {
	{'t9md/vim-choosewin', desc = 'window/tab 切换'},
	{
		'easymotion/vim-easymotion',
		config = function() vim.g.EasyMotion_smartcase = 1 end,
	},
	{ 'matze/vim-move', desc = '移动选定段落 <A-k> <A-j>' },
	{'adoyle-h/vim-emacscommandline', desc = 'Emacs 快捷键'},
	{'bkad/CamelCaseMotion'},
}

return M
