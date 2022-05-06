local M = {
	nil,
	disable = false,
}


M.requires = {
	{
		'plasticboy/vim-markdown',
		['for'] = 'markdown',
		config = function()
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_conceal = 0
			vim.g.vim_markdown_toc_autofit = 1
			vim.g.vim_markdown_emphasis_multiline = 0
			vim.g.vim_markdown_fenced_languages = {'csharp=cs', 'js=javascript'}
			vim.g.vim_markdown_new_list_item_indent = 2
		end
	},

	{
		'iamcco/markdown-preview.nvim',
		['for'] = 'markdown',
		['do'] = 'cd app & npm install',
	},

	{
		'adoyle-h/vim-MarkdownTOC',
		disable = false,
		desc = 'Table of Content generator',
		['for'] = 'markdown',
		branch = 'adoyle',
		config = function()
			vim.g.vmt_style = 'unordered'
			vim.g.vmt_list_item_char = '-'
			vim.g.vmt_fence_text = 'MarkdownTOC'
			vim.g.vmt_fence_closing_text = '/'..vim.g.vmt_fence_text

			vim.api.nvim_create_user_command('TocInsert', 'GenTocGFM', {})
			vim.api.nvim_create_user_command('TocUpdate', 'UpdateToc', {})
		end
	},
}

return M
