local M = {
	nil,
	desc = 'Copy&Paste Keymap',
	disable = false,
}

function M.config()
	vim.cmd [[
		" copy selected into system clipboard
		vnoremap <leader>y "+y
		" y$ -> Y Make Y behave like other capitals: D, C etc...
		nnoremap Y y$

		" paste from vim clipboard
		nnoremap <leader>p "0p
		xnoremap <leader>p "0p
		" paste from system clipboard
		nnoremap <leader>P "*p
		xnoremap <leader>P "*p
		" toggle paste mode
		noremap <M-p> :set paste!<CR>
	]]
end

return M
