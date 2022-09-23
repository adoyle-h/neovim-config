local M = { nil, disable = false }

local color = require('adoyle-neovim-config.config').config.color
local mainColor = color.orange
local bgColor = color.grey2

M.requires = {
	{
		'kevinhwang91/nvim-hlslens',
		disable = false,
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
		desc = '项目内内容搜索',
		on = { '<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF' },
		disable = false,
		config = function()
			vim.g.ctrlsf_auto_close = 0
			vim.g.ctrlsf_ignore_dir = { 'bower_components', 'node_modules', 'vendor' }
			vim.g.ctrlsf_context = '-C 3'
			vim.g.ctrlsf_follow_symlinks = 0
		end,
		keymaps = {
			{ 'n', '<leader>f', '<Plug>CtrlSFPrompt' },
			{ 'v', '<leader>f', '<Plug>CtrlSFVwordPath' },
		},
	},

	{
		'thinca/vim-visualstar',
		desc = 'visual 模型下查找增强',
		disable = false,
		config = function()
			vim.g.visualstar_no_default_key_mappings = 0
		end,
		keymaps = {
			{ 'x', '<C-n>', '<Plug>(visualstar-*)', { silent = true } },
			{ 'x', '<C-p>', '<Plug>(visualstar-#)', { silent = true } },
			{ 'x', 'g<C-n>', '<Plug>(visualstar-g*)', { silent = true } },
			{ 'x', 'g<C-p>', '<Plug>(visualstar-g#)', { silent = true } },
		},
	},

}

return M
