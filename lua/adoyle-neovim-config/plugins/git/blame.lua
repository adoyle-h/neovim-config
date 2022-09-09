local M = {
	'f-person/git-blame.nvim',
	desc = 'Git Blame',
	disable = false,
}

function M.config()
	local config = require('adoyle-neovim-config.config').global
	local color = config.color

	vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { silent = true, noremap = true })
	vim.g.gitblame_enabled = false
	vim.g.gitblame_message_template = '  <date> <author>: <summary>'
	vim.g.gitblame_date_format = '%Y/%m/%d %H:%M:%S'
	vim.cmd(vim.fn.printf('hi GitBlameVirtualText guifg=%s guibg=%s gui=italic', color.grey, color.cursorLineBG))
	vim.g.gitblame_highlight_group = 'GitBlameVirtualText'
	vim.g.gitblame_ignored_filetypes = config.ignoredFileTypesForSomePlugs
end

return M
