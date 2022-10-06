local config = require('adoyle-neovim-config.config').config

return {
	'phaazon/hop.nvim',
	branch = 'v2', -- optional but strongly recommended

	defaultConfig = {
		{ 'move', 'jump' },
		{
			keys = '12345asdghklqwertyuiopzxcvbnmfj',
			quit_key = '<Esc>',
			multi_windows = false,
			create_hl_autocmd = false,
		},
	},

	config = function()
		require('hop').setup(config.move.jump)
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

	highlights = { { 'HopNextKey', { fg = config.colors.green, bold = true } } },
}
