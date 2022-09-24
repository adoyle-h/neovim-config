local M = { nil, desc = 'Shortcuts for fast moving', disable = false }

local config = require('adoyle-neovim-config.config').config

local chooseWin = {
	't9md/vim-choosewin',
	desc = 'window/tab selector',
	disable = true, -- Because it does not support gui
	keymaps = { { 'n', '-', '<Plug>(choosewin)', { desc = 'choose window', silent = true } } },

	config = function()
		-- tmux-like overlay
		vim.g.choosewin_overlay_enable = 0
		vim.g.choosewin_statusline_replace = 1
		vim.g.choosewin_tabline_replace = 0 -- don't replace tabline
		vim.g.choosewin_overlay_shade = 0
		vim.g.choosewin_blink_on_land = 0 -- don't blink at land
		vim.g.choosewin_color_overlay = { cterm = { 33, 33 } }
		vim.g.choosewin_color_overlay_current = { cterm = { 196, 196 } }
		vim.g.choosewin_label_padding = 5
		vim.g.choosewin_color_bg = 234
		vim.g.choosewin_color_other = { cterm = { vim.g.choosewin_color_bg, 0 } }
		vim.g.choosewin_color_label = { cterm = { vim.g.choosewin_color_bg, 33 } }
		vim.g.choosewin_color_label_current = { cterm = { vim.g.choosewin_color_bg, 196 } }
		vim.g.choosewin_label = 'QWEASDZXC'
		vim.g.choosewin_tablabel = '1234567890'
		vim.g.choosewin_keymap = {
			['0'] = '<NOP>',
			['['] = 'tab_prev',
			[']'] = 'tab_next',
			['$'] = '<NOP>',
			x = '<NOP>',
			[';'] = '<NOP>',
			['-'] = 'previous',
			s = 'swap',
			S = 'swap_stay',
			['<CR>'] = 'win_land',
			h = 'tab_first',
			k = 'tab_prev',
			j = 'tab_next',
			l = 'tab_last',
		}
	end,
}

local windowSelector = {
	'https://gitlab.com/yorickpeterse/nvim-window.git',
	disable = false,
	config = function()
		require('nvim-window').setup({
			-- The characters available for hinting windows.
			chars = {
				-- LuaFormatter off
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
				'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
				-- LuaFormatter on
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

	end,

	keymaps = function()
		return { { 'n', '-', require('nvim-window').pick, { desc = 'choose window', silent = true } } }
	end,
}

local camelCaseMotion = {
	'bkad/CamelCaseMotion',
	disable = false,
	keymaps = {
		{ '', 'w', '<Plug>CamelCaseMotion_w', { silent = true } },
		{ '', 'b', '<Plug>CamelCaseMotion_b', { silent = true } },
		{ '', 'e', '<Plug>CamelCaseMotion_e', { silent = true } },
		{ '', 'ge', '<Plug>CamelCaseMotion_ge', { silent = true } },
		{ 'n', 'W', 'w', { noremap = true } },
		{ 'n', 'B', 'b', { noremap = true } },
		{ 'n', 'E', 'e', { noremap = true } },
		{ 'n', 'gE', 'ge', { noremap = true } },
	},
}

local fastMove = {
	'rainbowhxch/accelerated-jk.nvim',
	disable = false,
	desc = 'accelerates j/k movement steps while j or k key is repeating',
	config = function()
		require('accelerated-jk').setup(config.move.accelerated)
	end,
	keymaps = {
		{ 'n', 'j', '<Plug>(accelerated_jk_gj)', { desc = 'move cursor down' } },
		{ 'n', 'k', '<Plug>(accelerated_jk_gk)', { desc = 'move cursor up' } },
	},
}

local hop = {
	'phaazon/hop.nvim',
	branch = 'v2', -- optional but strongly recommended

	config = function()
		require('hop').setup(config.move.hop)
	end,

	keymaps = function()
		-- local HintDirection = require('hop.hint').HintDirection
		local HintPosition = require('hop.hint').HintPosition
		local hop = require('hop')

		return {
			{ '', 'fw', hop.hint_words, { desc = 'cursor jumps to the start of word' } },

			{
				'',
				'fe',
				function()
					hop.hint_words { hint_position = HintPosition.END }
				end,
				{ desc = 'cursor jumps to the end of word' },
			},

			{ '', 'fc', hop.hint_char1, { desc = 'cursor jumps to char which user type' } },
			{ '', 'f1', hop.hint_char1, { desc = 'cursor jumps to char which user type' } },
			{ '', 'f2', hop.hint_char2, { desc = 'cursor jumps to chars prefixed which user type' } },
			{ '', 'fl', hop.hint_lines_skip_whitespace, { desc = 'cursor jumps to line' } },
		}
	end,

	highlights = { { 'HopNextKey', { fg = config.color.green, bold = true } } },
}

M.requires = {
	{ 'matze/vim-move', desc = 'Use <A-h>/<A-j>/<A-k>/<A-l> to move char/line/block under cursor' },
	hop,
	windowSelector,
	chooseWin,
	camelCaseMotion,
	fastMove,
}

return M
