local M = { nil }

local config = require('adoyle-neovim-config.config').config
local color = config.color
local mainColor = color.orange
local bgColor = color.grey2

M.requires = {
	{
		'kevinhwang91/nvim-hlslens',
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

		keymaps = {
			{ 'n', '<leader>f', '<Plug>CtrlSFPrompt' },
			{ 'v', '<leader>f', '<Plug>CtrlSFVwordPath' },
		},

		defaultConfig = {
			{ 'search', 'ctrlsf' },
			{
				ignoreDir = config.ignore.fileSearch.names, --
				context = '-C 3',
				autoClose = 0,
				followSymlinks = 0,
			},
		},

		config = function()
			local conf = config.search.ctrlsf
			vim.g.ctrlsf_auto_close = conf.autoClose
			vim.g.ctrlsf_ignore_dir = conf.ignoreDir
			vim.g.ctrlsf_context = conf.content
			vim.g.ctrlsf_follow_symlinks = conf.followSymlinks
		end,
	},

	{
		'thinca/vim-visualstar',
		desc = 'Enable <C-n> search in visual mode',

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
