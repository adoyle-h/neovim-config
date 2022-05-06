local M = {
	nil,
	desc = 'Search Keymaps',
	disable = false,
}

function M.config()
	vim.cmd [[
		" quick search word
		nnoremap <C-n> *
		nnoremap <C-p> #
		nnoremap g<C-n> g*
		nnoremap g<C-p> g#

		" clear highlighted search
		noremap <silent> <leader>C :let @/ = ""<CR>
		" toggle highlighted search
		noremap <leader>h :set hlsearch! hlsearch?<CR>
	]]
end

return M
