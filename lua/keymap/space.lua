local M = {
	nil,
	desc = 'Insert spaces or newline Keymap',
	disable = false,
}

function M.config()
	vim.cmd [[
		" insert a space at right position of cursor
		nnoremap <space><space> a<space><esc>
		nnoremap ]<space> a<space><esc>
		" insert a space at left position of cursor
		nnoremap [<space> i<space><esc>

		" add a blank line before current line
		nnoremap <silent><C-k> :put! =''<CR>j
		" add a blank line after current line
		nnoremap <silent><C-j> :put =''<CR>k
		" split line from current cursor position
		nnoremap K i<Enter><Esc>
	]]
end

return M
