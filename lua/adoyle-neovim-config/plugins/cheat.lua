local M = {
	nil,
	desc = 'cheatsheet',
	disable = true,
}

M.requires = {
	{'lifepillar/vim-cheat40', on = 'Cheat40', desc = '显示快捷键指南'},
	{'liuchengxu/vim-which-key', on = {'WhichKey', 'WhichKey!'}, desc = '显示匹配某个前缀的快捷键'},
}

return M
