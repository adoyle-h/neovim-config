local M = { nil, desc = 'Format Settings', disable = false }

local EasyAlign = {
	'junegunn/vim-easy-align',
	disable = false,
	on = { '<Plug>(EasyAlign)', 'EasyAlign' },

	keymaps = {
		{ 'n', '<leader>A', '<Plug>(EasyAlign)' },
		{ 'x', '<leader>A', '<Plug>(EasyAlign)' },
		{ 'n', '<leader>a', '<Plug>(LiveEasyAlign)' },
		{ 'x', '<leader>a', '<Plug>(LiveEasyAlign)' },
	},

	config = function()
		vim.g.easy_align_delimiters = {
			['>'] = { pattern = '>>|=>|>' },

			['/'] = { pattern = '//+|/*|*/', delimiter_align = 'l', ignore_groups = { '!Comment' } },

			[']'] = { pattern = '[[]]', left_margin = 0, right_margin = 0, stick_to_left = 0 },

			[')'] = { pattern = '[()]', left_margin = 0, right_margin = 0, stick_to_left = 0 },

			['d'] = { pattern = ' (S+s*[;=])@=', left_margin = 0, right_margin = 0 },
		}
	end,
}

M.requires = {
	EasyAlign,
	{ 'editorconfig/editorconfig-vim', desc = '.editorconfig support' },
	{
		'rhlobo/vim-super-retab',
		on = { 'Space2Tab', 'Tab2Space' },
		desc = 'Convert spaces to tabs, or tabs to spaces',
	},
	{ 'tpope/vim-sleuth', desc = '根据上下文自动调整 shiftwidth expandtab' },
}

return M
