local api = vim.api

local M = {
	'nishigori/increment-activator',
	desc = 'increment and decrement',

	on = { '<Plug>(increment-activator-increment)', '<Plug>(increment-activator-decrement)' },

	keymaps = {
		{
			'n',
			'<leader>ii',
			function()
				vim.fn['increment_activator#increment']()
				api.nvim_feedkeys(api.nvim_replace_termcodes('<leader>i', true, false, true), 't', true)
			end,
			{ desc = 'Increment word under cursor' },
		},

		{
			'n',
			'<leader>iI',
			function()
				vim.fn['increment_activator#decrement']()
				api.nvim_feedkeys(api.nvim_replace_termcodes('<leader>i', true, false, true), 't', true)
			end,
			{ desc = 'Decrement word under cursor' },
		},
	},

	config = function(config)
		local conf = config.increment
		vim.g.increment_activator_no_default_key_mappings = 1
		vim.g.increment_activator_filetype_candidates = conf
	end,
}

M.defaultConfig = {
	'increment',
	{
		['_'] = {
			-- LuaFormatter off
			{
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
				'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
			},
			{'一', '二', '三', '四', '五', '六', '七', '八', '九', '十'},
			{'none', 'debug', 'info', 'warn', 'error'},
			{'todo', 'done'},
			{'ToDo', 'Done'},
			{'low', 'normal', 'high'},
			{'open', 'close'},
			-- LuaFormatter on
		},
	},
}

return M
