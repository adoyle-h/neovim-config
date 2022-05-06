local M = {
	nil,
	disable = false,
}

M.requires = {
	{
		'luochen1990/rainbow',
		 desc = '括号颜色配对。Attention: 可能会影响到其他语法着色',
		 disable = false,

		 config = function()
			 vim.g.rainbow_active = 1 -- Or 0 if you want to enable it later via :RainbowToggle
			 vim.g.rainbow_conf = {
				 ctermfgs = {'24', '166', '119', '33', '48', '229', '202', '4', '13', '105', '101'},

				 guifgs = {
					 '#005f87', '#d75f00', '#87ff5f', '#0087ff', '#00ff87', '#ffffaf', '#ff5f00', '#000080',
					 '#ff00ff', '#8787ff', '#87875f'
				 },

				 separately = {
					 nerdtree = 0,
				 },
			 }
		 end
	 },

	 {
		 'tpope/vim-surround',
		 desc = 'mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.',
	 },

	 {
		 'Raimondi/delimitMate',
		 desc = 'automatic closing of quotes, parenthesis, brackets, etc.',
	 },

	 {
		 'tpope/vim-ragtag',
		 desc = 'like closetag. endings for html, xml, etc. - enhance vim-surround',
	 },

	 {
		 'alvan/vim-closetag',
		 desc = '',
		 config = function()
			 vim.g.closetag_filenames = "*.html,*.xml,*.xhtml,*.htm,*.jsx"
		 end,
	 },

	 {
		'vim-scripts/matchit.zip',
		 desc = 'extended % matching',
	 },
 }

return M
