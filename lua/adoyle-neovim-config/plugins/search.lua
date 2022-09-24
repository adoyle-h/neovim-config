local M = { nil, disable = false }

local color = require('adoyle-neovim-config.config').config.color
local mainColor = color.orange
local bgColor = color.grey2

M.requires = {
	{
		'kevinhwang91/nvim-hlslens',
		disable = false,
		desc = 'Highlight search floating',
		highlights = {
			{ 'Search', { bg = 'none', fg = mainColor, underline = true } },
			{ 'IncSearch', { bg = 'none', fg = mainColor, underline = true } },
			-- 1. HlSearchLensNear: highlight the nearest virtual text
			{ 'HlSearchLensNear', { bg = bgColor, fg = mainColor } },
			-- 2. HlSearchLens: highlight virtual text except for the nearest one
			{ 'HlSearchLens', { bg = bgColor, fg = color.grey } },
			-- 3. HlSearchNear: highlight the nearest matched instance
			{ 'HlSearchNear', { bg = mainColor, fg = color.black } },
			-- 4. HlSearchFloat: highlight the nearest text for the floating window
			{ 'HlSearchFloat', { bg = bgColor, fg = mainColor } },
		},
	},

	{
		'dyng/ctrlsf.vim',
		desc = 'Search all contents in workspace',
		on = { '<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF' },
		disable = false,

		keymaps = {
			{ 'n', '<leader>f', '<Plug>CtrlSFPrompt' },
			{ 'v', '<leader>f', '<Plug>CtrlSFVwordPath' },
		},

		config = function()
			vim.g.ctrlsf_auto_close = 0
			vim.g.ctrlsf_ignore_dir = { 'bower_components', 'node_modules', 'vendor' }
			vim.g.ctrlsf_context = '-C 3'
			vim.g.ctrlsf_follow_symlinks = 0
		end,
	},

	{
		'thinca/vim-visualstar',
		desc = 'Enable <C-n> search in visual mode',
		disable = false,

		keymaps = {
			{ 'x', '<C-n>', '<Plug>(visualstar-*)', { silent = true } },
			{ 'x', '<C-p>', '<Plug>(visualstar-#)', { silent = true } },
			{ 'x', 'g<C-n>', '<Plug>(visualstar-g*)', { silent = true } },
			{ 'x', 'g<C-p>', '<Plug>(visualstar-g#)', { silent = true } },
		},

		config = function()
			vim.g.visualstar_no_default_key_mappings = 0
		end,
	},

}

return M
