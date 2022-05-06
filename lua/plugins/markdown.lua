local function configMarkdownTOC()
	vim.g.vmt_style = 'unordered'
	vim.g.vmt_list_item_char = '-'
	vim.g.vmt_fence_text = 'MarkdownTOC'
	vim.g.vmt_fence_closing_text = '/'..vim.g.vmt_fence_text

	vim.api.nvim_create_user_command('TocInsert', 'GenTocGFM', {})
	vim.api.nvim_create_user_command('TocUpdate', 'UpdateToc', {})
end

local M = {
	'',
	disable = false,

	requires = {
		{
			'plasticboy/vim-markdown',
			['for'] = 'markdown',
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
			config = configMarkdownTOC,
		},
	}
}

return M
