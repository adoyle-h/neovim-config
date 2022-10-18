local config = require('adoyle-neovim-config.config').config

return {
	'nvim-treesitter/nvim-treesitter-context',
	desc = 'Shows the context of the currently visible buffer contents.',
	disable = true,

	config = function()
		require('treesitter-context').setup(config.treesitterContext)
	end,

	-- doc: https://github.com/nvim-treesitter/nvim-treesitter-context
	defaultConfig = {
		'treesitterContext',
		{
			mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		},
	},
}
