local config = require('adoyle-neovim-config.config').get_global()

local M = {
	nil,
	desc = 'Git Plugins',
	disable = false,

	requires = {
		require 'adoyle-neovim-config.plugins.git-gutter',

		{
			'f-person/git-blame.nvim',
			config = function()
				local color = config.color
				vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { silent = true, noremap = true })
				vim.g.gitblame_enabled = false
				vim.g.gitblame_message_template = '  <date> <author>: <summary>'
				vim.g.gitblame_date_format = '%Y/%m/%d %H:%M:%S'
				vim.cmd(vim.fn.printf('hi GitBlameVirtualText guifg=%s guibg=%s gui=italic', color.grey, color.cursorLineBG))
				vim.g.gitblame_highlight_group = 'GitBlameVirtualText'
				vim.g.gitblame_ignored_filetypes = config.ignoredFileTypesForSomePlugs
			end
		},

		{
			'tpope/vim-fugitive',
			desc = 'git 命令 in vim',
			disable = false,
		},

		{
			'gregsexton/gitv',
			desc = 'git log in vim',
			disable = false,
			config = function()
				vim.g.Gitv_OpenPreviewOnLaunch = 0
				-- vim.g.Gitv_PreviewOptions = '--stat'
				vim.g.Gitv_CustomMappings = {
					let = '|',
					stat = 's',
					vstat = 's',
					head = 'H',
					delete = 'dd',
					vdelete = 'dd',
				}
			end,
		},
	},
}

return M
