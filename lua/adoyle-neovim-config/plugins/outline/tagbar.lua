local M = {
	'majutsushi/tagbar',
	desc = 'Outline - tagbar',
	disable = false,
	requires = {},
}

function M.config()
	vim.g.tagbar_autofocus = 1
	vim.g.tagbar_case_insensitive = 1
	vim.g.tagbar_sort = 1
	vim.g.tagbar_type_go = {
		ctagstype = 'go',
		kinds = {
			'p:package',
			'i:imports:1',
			'c:constants',
			'v:variables',
			't:types',
			'n:interfaces',
			'w:fields',
			'e:embedded',
			'm:methods',
			'r:constructor',
			'f:functions',
		},
		sro = '.',
		kind2scope = {
			t = 'ctype',
			n = 'ntype',
		},
		scope2kind = {
			ctype = 't',
			ntype = 'n',
		},
		ctagsbin = 'gotags',
		ctagsargs = '-sort -silent',
	}

	vim.cmd [[
		noremap <leader>tb :TagbarToggle fj<CR>
	]]
end

return M
