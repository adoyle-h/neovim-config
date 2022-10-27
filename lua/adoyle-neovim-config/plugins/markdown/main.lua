return {
	'plasticboy/vim-markdown',
	['for'] = 'markdown',

	defaultConfig = {
		{ 'markdown', 'main' },
		{
			frontmatter = 1,
			conceal = 1,
			conceal_code_blocks = 0,
			toc_autofit = 1,
			emphasis_multiline = 0,
			fenced_languages = { 'csharp=cs', 'js=javascript' },
			new_list_item_indent = 2,
		},
	},

	config = function()
		local conf = require('adoyle-neovim-config.config').config.markdown.main

		vim.g.vim_markdown_frontmatter = conf.frontmatter
		vim.g.vim_markdown_conceal = conf.conceal
		vim.g.vim_markdown_conceal_code_blocks = conf.conceal_code_blocks
		vim.g.vim_markdown_toc_autofit = conf.toc_autofit
		vim.g.vim_markdown_emphasis_multiline = conf.emphasis_multiline
		vim.g.vim_markdown_fenced_languages = conf.fenced_languages
		vim.g.vim_markdown_new_list_item_indent = conf.new_list_item_indent
	end,
}
