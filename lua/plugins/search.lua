local M = {
	nil,
	disable = false,
}

local function configCtrlSF()
	vim.g.ctrlsf_auto_close = 0
	vim.g.ctrlsf_ignore_dir = {'bower_components', 'node_modules', 'vendor'}
	vim.g.ctrlsf_context = '-C 3'
	vim.g.ctrlsf_follow_symlinks = 0

	vim.cmd [[
		nmap <leader>f <Plug>CtrlSFPrompt
		vmap <leader>f <Plug>CtrlSFVwordPath
	]]
end

M.requires = {
	{
		'kevinhwang91/nvim-hlslens',
		disable = false,
		config = function()
			vim.cmd('hi HlSearchLens guibg=' .. vim.config.color.grey2)
		end,
	},

	{
		'dyng/ctrlsf.vim',
		desc = '项目内内容搜索',
		on = {'<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF'},
		disable = false,
		config = configCtrlSF,
	},

	{
		'thinca/vim-visualstar',
		desc = 'visual 模型下查找增强',
		disable = false,
		config = function()
			vim.g.visualstar_no_default_key_mappings = 0

			vim.cmd [[
				" xnoremap cannot work!
				silent! xmap <C-n> <Plug>(visualstar-*)
				silent! xmap <C-p> <Plug>(visualstar-#)
				silent! xmap g<C-n> <Plug>(visualstar-g*)
				silent! xmap g<C-p> <Plug>(visualstar-g#)
			]]
		end,
	},

}

return M
