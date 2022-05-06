local M = {
	nil,
	desc = 'Shortcuts for fast moving',
	disable = false,
}

local function configChooseWin()
	-- tmux-like overlay
	vim.g.choosewin_overlay_enable = 0
	vim.g.choosewin_statusline_replace = 1
	vim.g.choosewin_tabline_replace = 0 -- don't replace tabline
	vim.g.choosewin_overlay_shade = 0
	vim.g.choosewin_blink_on_land = 0 -- don't blink at land
	vim.g.choosewin_color_overlay = {
		cterm = {33, 33}
	}
	vim.g.choosewin_color_overlay_current = {
		cterm= {196, 196}
	}
	vim.g.choosewin_label_padding = 5
	vim.g.choosewin_color_bg = 234
	vim.g.choosewin_color_other = {
		cterm= {vim.g.choosewin_color_bg, 0}
	}
	vim.g.choosewin_color_label = {
		cterm= {vim.g.choosewin_color_bg, 33}
	}
	vim.g.choosewin_color_label_current = {
		cterm= {vim.g.choosewin_color_bg, 196}
	}
	vim.g.choosewin_label = 'QWEASDZXC'
	vim.g.choosewin_tablabel = '1234567890'
	vim.g.choosewin_keymap = {
		['0']    = '<NOP>',
		['[']    = 'tab_prev',
		[']']    = 'tab_next',
		['$']    = '<NOP>',
		x        = '<NOP>',
		[';']    = '<NOP>',
		['-']    = 'previous',
		s        = 'swap',
		S        = 'swap_stay',
		['<CR>'] = 'win_land',
		h        = 'tab_first',
		k        = 'tab_prev',
		j        = 'tab_next',
		l        = 'tab_last',
	}

	vim.cmd 'nmap - <Plug>(choosewin)'
end

local function configNvimWindow()
	require('nvim-window').setup({
		-- The characters available for hinting windows.
		chars = {
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
			'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
		},

		-- A group to use for overwriting the Normal highlight group in the floating
		-- window. This can be used to change the background color.
		normal_hl = 'NvimWindowFloating',


		-- The highlight group to apply to the line that contains the hint characters.
		-- This is used to make them stand out more.
		hint_hl = 'Bold',

		-- The border style to use for the floating window.
		border = 'single'
	})

	vim.cmd [[
		map <silent> - :lua require('nvim-window').pick()<CR>
		hi NvimWindowFloating guifg=#000000 guibg=#9AC3DE
	]]
end

local function configCamelCaseMotion()
	vim.cmd [[
		map <silent> w <Plug>CamelCaseMotion_w
		map <silent> b <Plug>CamelCaseMotion_b
		map <silent> e <Plug>CamelCaseMotion_e
		map <silent> ge <Plug>CamelCaseMotion_ge
		noremap W w
		noremap B b
		noremap E e
		noremap gE ge
	]]
end

local function configEasyMotion()
	vim.g.EasyMotion_smartcase = 1
	vim.cmd [[
		map f <Plug>(easymotion-prefix)
		map f. <Plug>(easymotion-repeat)
	]]
end

M.requires = {
	{'https://gitlab.com/yorickpeterse/nvim-window.git', config = configNvimWindow},
	{'t9md/vim-choosewin', desc = 'window/tab 切换', config = configChooseWin, disable = true}, -- not support gui
	{ 'easymotion/vim-easymotion', config = configEasyMotion },
	{ 'matze/vim-move', desc = '移动选定段落 <A-k> <A-j>' },
	{'adoyle-h/vim-emacscommandline', desc = 'Emacs 快捷键'},
	{'bkad/CamelCaseMotion', config = configCamelCaseMotion},
}

return M
