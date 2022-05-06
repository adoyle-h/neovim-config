local M = {
	nil,
	desc = 'Tab Keymaps',
	disable = false,
}

function M.config()
	vim.cmd [[
		let g:lasttab = 1
		au TabLeave * let g:lasttab = tabpagenr()
		noremap <C-T>t- :execute "tabn ".g:lasttab<CR>
		noremap <C-T>k :tabprev<CR>
		noremap <C-T>j :tabnext<CR>
		noremap [t :tabprev<CR>
		noremap ]t :tabnext<CR>
		" noremap <leader>h :tabmove -<CR>
		" noremap <leader>l :tabmove +<CR>
		noremap <C-T>n :tabnew<CR>
		noremap <C-T>x :tabclose<CR>

		" switch tab in normal mode
		noremap <leader>1 1gt
		noremap <leader>2 2gt
		noremap <leader>3 3gt
		noremap <leader>4 4gt
		noremap <leader>5 5gt
		noremap <leader>6 6gt
		noremap <leader>7 7gt
		noremap <leader>8 8gt
		noremap <leader>9 9gt
		noremap <leader>0 :tablast<CR>
	]]
end

return M
