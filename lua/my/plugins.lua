local my = {}

my.highlights = function(config)
	local c = config.colors
	return { CmpGhostText = { fg = c.grey4, bg = c.darkBlue } }
end

my.filetypes = {
	markdown = function()
		vim.keymap.set('n', 'gh', ':Telescope heading<cr>',
			{ silent = true, desc = 'Jump to heading', buffer = true })
	end,
}

---@diagnostic disable-next-line: unused-local
return function(load, config)
	return {
		load('profiling'),
		load('zk'),
		load('node'),
		load('curl'),
		load('latex'),
		load('calendar'),
		load('todo'),
		load('zen'),
		load('mark'),
		load('bookmark'),
		load('funny', { disable = true }),
		load('noice', { disable = true }),

		-- for debug these plugins
		{ 'karb94/neoscroll.nvim', disable = false },
		{ 'onedarkpro', disable = false },
		{ 'nvim-treesitter/nvim-treesitter-context', disable = true },
		{ 'dmitmel/cmp-cmdline-history', disable = true },
		{ 'treesitter', disable = false },

		{
			'Vonr/align.nvim',
			keymaps = {
				{
					'x',
					'aa',
					function()
						require'align'.align_to_string(false, true, true)
					end,
					{ desc = 'Aligns to a string (to left) with previews', noremap = true, silent = true },
				},

				{
					'x',
					'as',
					function()
						require'align'.align_to_string(false, false, true)
					end,
					{ desc = 'Aligns to a string (to right) with previews', noremap = true, silent = true },
				},

				{
					'x',
					'ar',
					function()
						require'align'.align_to_string(true, true, true)
					end,
					{ desc = 'Aligns to a Lua pattern (to left) with previews', noremap = true, silent = true },
				},
			},
		},

		my,
	}
end
