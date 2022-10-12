return {
	'markdown',

	desc = 'Markdown Plugins',

	requires = {
		require('adoyle-neovim-config.plugins.markdown.main'),
		require('adoyle-neovim-config.plugins.markdown.toc'),
		{ 'iamcco/markdown-preview.nvim', ['for'] = 'markdown', ['do'] = 'cd app & npm install' },
	},

	highlights = function(config)
		local colors = config.colors
		local linkFG = '#30B17D'
		local grey = colors.grey

		return {
			-- Use :TSHighlightCapturesUnderCursor to query highlight group name
			{ 'htmlArg', { fg = colors.cyan } },
			{ 'htmlBold', { fg = colors.orange, bold = true } },
			{ 'htmlItalic', { fg = colors.purple, italic = true } },
			{ 'htmlLink', { fg = colors.green, underline = true } },
			{ 'htmlH1', { fg = colors.blue, bold = true } },
			{ 'htmlH2', { link = 'htmlH1' } },
			{ 'htmlH3', { link = 'htmlH1' } },
			{ 'htmlH4', { link = 'htmlH1' } },
			{ 'htmlH5', { link = 'htmlH1' } },
			{ 'htmlH6', { link = 'htmlH1' } },
			{ 'htmlSpecialChar', { link = 'SpecialChar' } },
			{ 'htmlSpecialTagName', { fg = colors.red } },
			{ 'htmlTag', { fg = colors.blue } },
			{ 'htmlEndTag', { link = 'htmlTag' } },
			{ 'htmlTagN', { fg = colors.blue } },
			{ 'htmlTagName', { fg = colors.blue } },
			{ 'htmlTitle', { fg = colors.fg } },
			{ 'htmlString', { fg = colors.orange } },

			{ 'mkdURL', { fg = colors.green } },
			{ 'mkdLink', { fg = linkFG, underline = true } },
			{ 'mkdLinkDef', { fg = linkFG } },
			{ 'mkdListItem', { fg = grey } },
			{ 'mkdCode', { fg = '#6D78BC' } },
			{ 'mkdCodeStart', { fg = grey } },
			{ 'mkdCodeEnd', { fg = grey } },
		}
	end,
}
