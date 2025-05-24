---@diagnostic disable-next-line: unused-local
return function(load, config)
	return {
		{
			highlights = require('my.highlights'),
			filetypes = require('my.filetypes').callbacks,
			commands = require('my.commands'),
			telescopes = require('my.telescopes'),
			autocmds = require('my.autocmds'),
		},

		require('my.null-ls').plugins,

		-- load('profiling'),
		-- load('zk'),
		load('node'),
		-- load('curl'),
		load('latex'),
		load('calendar'),
		load('todo'),
		load('zen'),
		load('hex'),
		-- load('codeium'),
		-- { 'cmp-codeium', disable = false },
		load('funny', { disable = true }),
		{ 'noice', disable = true },
		{ 'session', disable = false },

		-- { 'adoyle-h/one.nvim', branch = 'master' },

		-- for debug these plugins
		{ 'onedarkpro', disable = false },
		{ 'dmitmel/cmp-cmdline-history', disable = true },
		{ 'treesitter', disable = false },
		{ 'ai', disable = false },

		{
			'xiyaowong/telescope-emoji.nvim',
			config = function()
				require('telescope').load_extension('emoji')
			end,
		},

		{
			'Vonr/align.nvim',
			branch = 'v2',
			keymaps = {
				{
					'x',
					'aa',
					function()
						require('align').align_to_string({ preview = true, regex = false })
					end,
					{ desc = 'Aligns to a string (to left) with previews', noremap = true, silent = true },
				},

				{
					'x',
					'as',
					function()
						require('align').align_to_string({ preview = true, regex = false, reverse = true })
					end,
					{ desc = 'Aligns to a string (to right) with previews', noremap = true, silent = true },
				},

				{
					'x',
					'ar',
					function()
						require('align').align_to_string({ preview = true, regex = true, reverse = true })
					end,
					{ desc = 'Aligns to a Lua pattern (to left) with previews', noremap = true, silent = true },
				},
			},
		},
	}
end
