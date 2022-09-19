local M = { 'scrooloose/nerdcommenter', desc = '注释插件', disable = false }

function M.config()
	vim.g.NERDSpaceDelims = 1
	vim.g.NERDRemoveExtraSpaces = 1
	vim.g.NERDCommentWholeLinesInVMode = 1
	vim.g.NERDCustomDelimiters = {
		['javascript.jsx'] = { left = '//', right = '', leftAlt = '{/*', rightAlt = '*/}' },
		plantuml = { left = '\'', right = '' },
	}
end

return M
