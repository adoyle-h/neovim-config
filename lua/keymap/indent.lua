local M = {
	nil,
	desc = 'Indent Keymap',
	disable = false,
}

function M.config()
	vim.cmd [[
		" indent line while keep visual selected
		vnoremap < <gv
		vnoremap > >gv
		" indent line
		nnoremap > >>
		nnoremap < <<
	]]
end

return M
