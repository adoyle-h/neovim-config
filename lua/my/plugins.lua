local my = {}

my.highlights = require('my.highlights')

my.filetypes = require('my.filetypes')

my.commands = require('my.commands')

---@diagnostic disable-next-line: unused-local
return function(load, config)
	return {
		-- load('profiling'),
		load('zk'),
		load('node'),
		load('curl'),
		load('latex'),
		load('calendar'),
		load('todo'),
		load('zen'),
		load('mark'),
		load('funny', { disable = true }),
		{ 'noice', disable = false },

		-- for debug these plugins
		{ 'onedarkpro', disable = false },
		{ 'dmitmel/cmp-cmdline-history', disable = true },
		{ 'treesitter', disable = false },
		{ 'iamcco/markdown-preview.nvim', disable = false },

		{
			'Vonr/align.nvim',
			keymaps = {
				{
					'x',
					'aa',
					function()
						require('align').align_to_string(false, true, true)
					end,
					{ desc = 'Aligns to a string (to left) with previews', noremap = true, silent = true },
				},

				{
					'x',
					'as',
					function()
						require('align').align_to_string(false, false, true)
					end,
					{ desc = 'Aligns to a string (to right) with previews', noremap = true, silent = true },
				},

				{
					'x',
					'ar',
					function()
						require('align').align_to_string(true, true, true)
					end,
					{ desc = 'Aligns to a Lua pattern (to left) with previews', noremap = true, silent = true },
				},
			},
		},

		my,
	}
end
