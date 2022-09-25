local M = { nil, desc = 'The fast cursor selection with text-objects' }
local config = require('adoyle-neovim-config.config').config

M.requires = {
	{
		'gcmt/wildfire.vim',
		desc = 'Select the text-objects',
		keymaps = {
			{ '', '<leader>v', '<Plug>(wildfire-fuel)', desc = 'select the next closest text object.' },
			{ '', '<leader>V', '<Plug>(wildfire-water)', desc = 'select the previous closest text object.' },
			{ 'n', '<leader>sv', '<Plug>(wildfire-quick-select)' },
		},
	},

	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		disable = config.pluginOpts['nvim-treesitter/nvim-treesitter'].disable,
		defaultConfig = {
			{ 'select', 'textobjects' },

			{
				{
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@class.outer',
							-- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
							['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
						},
						-- You can choose the select mode (default is charwise 'v')
						selection_modes = {
							['@parameter.outer'] = 'v', -- charwise
							['@function.outer'] = 'V', -- linewise
							['@class.outer'] = '<c-v>', -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding xor succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						include_surrounding_whitespace = true,
					},
				},
			},
		},
		config = function()
			require('nvim-treesitter.configs').setup { textobjects = config.select.textobjects }
		end,
	},
}

return M
