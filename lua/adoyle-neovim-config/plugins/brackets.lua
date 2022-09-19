local M = { nil, disable = false }

M.requires = {
	{
		'tpope/vim-surround',
		desc = 'mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.',
	},

	{ 'Raimondi/delimitMate', desc = 'automatic closing of quotes, parenthesis, brackets, etc.' },

	{ 'tpope/vim-ragtag', desc = 'like closetag. endings for html, xml, etc. - enhance vim-surround' },

	{
		'alvan/vim-closetag',
		desc = '',
		config = function()
			vim.g.closetag_filenames = '*.html,*.xml,*.xhtml,*.htm,*.jsx'
		end,
	},

	{ 'vim-scripts/matchit.zip', desc = 'extended % matching' },
}

return M
