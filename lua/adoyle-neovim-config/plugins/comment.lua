local M = {
	'scrooloose/nerdcommenter',
	desc = 'comment codes',
	defaultConfig = {
		'comment',
		{
			spaceDelims = 1,
			removeExtraSpaces = 1,
			commentWholeLinesInVMode = 1,
			delimiters = {
				['javascript.jsx'] = { left = '//', right = '', leftAlt = '{/*', rightAlt = '*/}' },
				plantuml = { left = '\'', right = '' },
			},
		},
	},
}

function M.config()
	local conf = require('adoyle-neovim-config.config').config.comment

	vim.g.NERDSpaceDelims = conf.spaceDelims
	vim.g.NERDRemoveExtraSpaces = conf.removeExtraSpaces
	vim.g.NERDCommentWholeLinesInVMode = conf.commentWholeLinesInVMode
	vim.g.NERDCustomDelimiters = conf.delimiters
end

return M
