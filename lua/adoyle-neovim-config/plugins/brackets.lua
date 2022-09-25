local M = { nil, desc = '' }
local config = require('adoyle-neovim-config.config').config

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
		defaultConfig = { { 'brackets', 'closetag' }, { filenames = '*.html,*.xml,*.xhtml,*.htm,*.jsx' } },
		config = function()
			vim.g.closetag_filenames = config.brackets.closetag.filenames
		end,
	},

	{ 'vim-scripts/matchit.zip', desc = 'extended % matching' },
}

return M
