local M = {
	nil,
	desc = 'Shortcuts for fast moving',
	disable = false,
}

local color = require('adoyle-neovim-config.config').global.color

local chooseWin = {
	't9md/vim-choosewin',
	desc = 'window/tab 切换',
	disable = true, -- Because it does not support gui

	config = function()
		-- tmux-like overlay
		vim.g.choosewin_overlay_enable = 0
		vim.g.choosewin_statusline_replace = 1
		vim.g.choosewin_tabline_replace = 0 -- don't replace tabline
		vim.g.choosewin_overlay_shade = 0
		vim.g.choosewin_blink_on_land = 0 -- don't blink at land
		vim.g.choosewin_color_overlay = {
			cterm = { 33, 33 }
		}
		vim.g.choosewin_color_overlay_current = {
			cterm = { 196, 196 }
		}
		vim.g.choosewin_label_padding = 5
		vim.g.choosewin_color_bg = 234
		vim.g.choosewin_color_other = {
			cterm = { vim.g.choosewin_color_bg, 0 }
		}
		vim.g.choosewin_color_label = {
			cterm = { vim.g.choosewin_color_bg, 33 }
		}
		vim.g.choosewin_color_label_current = {
			cterm = { vim.g.choosewin_color_bg, 196 }
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
}

local windowSelector = {
	'https://gitlab.com/yorickpeterse/nvim-window.git',
	config = function()
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
			border = 'rounded', -- ':h nvim_open_win'
		})

		vim.keymap.set({ 'n' }, '-', function()
			require('nvim-window').pick()
		end, { noremap = true, silent = true })

		vim.cmd.hi { 'NvimWindowFloating', 'guifg=' .. color.blue, 'guibg=' .. color.black }
	end
}

local camelCaseMotion = {
	'bkad/CamelCaseMotion',
	disable = false,
	config = function()
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
}

local easyMotion = {
	'easymotion/vim-easymotion',
	disable = false,
	config = function()
		vim.g.EasyMotion_smartcase = 1
		vim.cmd [[
			map f <Plug>(easymotion-prefix)
			map f. <Plug>(easymotion-repeat)
		]]
	end
}

local fastMove = {
	'rainbowhxch/accelerated-jk.nvim',
	disable = false,
	desc = 'j/k 移动自动加速',

	config = function()
		require('accelerated-jk').setup({
			mode = 'time_driven',
			enable_deceleration = false,
			acceleration_limit = 200,
			acceleration_table = { 5, 10, 12, 20, 30 },
		})
		vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
		vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
	end
}

M.requires = {
	{ 'matze/vim-move', desc = '移动选定段落 <A-k> <A-j>' },
	{ 'adoyle-h/vim-emacscommandline', desc = 'Emacs 快捷键' },
	easyMotion,
	windowSelector,
	chooseWin,
	camelCaseMotion,
	fastMove,
}

return M
