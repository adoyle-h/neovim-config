local M = {
	nil,
	desc = 'Emacs Editline Keymap',
	disable = false,
}

function M.config()
	vim.cmd [[
		inoremap <silent> <C-a> <Esc>I
		inoremap <silent> <C-e> <Esc>A
		inoremap <silent> <C-b> <Esc>ha
		inoremap <silent> <C-f> <Esc>la
		inoremap <silent> <M-b> <Esc>bi
		inoremap <silent> <M-f> <Esc>Ea
		inoremap <silent> <M-d> <Esc>dwa
		inoremap <silent> <C-d> <Esc>dla
		inoremap <silent> <C-w> <Esc>bdei
		inoremap <silent> <C-k> <Esc>Da
		inoremap <silent> <C-u> <Esc>d0
	]]
end

return M
