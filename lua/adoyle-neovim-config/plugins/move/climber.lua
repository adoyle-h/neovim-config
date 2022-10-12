return {
	'drybalka/tree-climber.nvim',
	keymaps = function()
		local keyopts = { noremap = true, silent = true }
		local climber = require('tree-climber')

		return {
			{
				{ 'n', 'v', 'o' },
				'th',
				function()
					climber.goto_parent({ skip_comments = true })
				end,
				keyopts,
			},
			{
				{ 'n', 'v', 'o' },
				'tl',
				function()
					climber.goto_child({ skip_comments = true })
				end,
				keyopts,
			},
			{
				{ 'n', 'v', 'o' },
				'tj',
				function()
					climber.goto_next({ skip_comments = true })
				end,
				keyopts,
			},
			{
				{ 'n', 'v', 'o' },
				'tk',
				function()
					climber.goto_prev({ skip_comments = true })
				end,
				keyopts,
			},
			{ { 'v', 'o' }, 'in', climber.select_node, keyopts },
			{ 'n', '<M-h>', climber.swap_prev, keyopts },
			{ 'n', '<M-l>', climber.swap_next, keyopts },
		}
	end,
}
