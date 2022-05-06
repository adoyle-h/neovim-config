local M = {
	nil,
	desc = 'Format Settings',
	disable = false,
}

M.requires = {
	{'editorconfig/editorconfig-vim', desc = '.editorconfig support'},
	{'sbdchd/neoformat'},
	{'Chiel92/vim-autoformat', desc = '整理格式。并且自带的 RemoveTrailingSpaces 也可以去空格'},
	{'rhlobo/vim-super-retab', on = {'Space2Tab', 'Tab2Space'}},
	{'tpope/vim-sleuth', desc = '根据上下文自动调整 shiftwidth expandtab'},
	{'junegunn/vim-easy-align', on = {'<Plug>(EasyAlign)', 'EasyAlign'} },
	{'tpope/vim-abolish', desc = 'https://github.com/tpope/vim-abolish#coercion'},
}

return M
