local M = { nil, desc = 'Tab Keymaps', disable = false }

function M.config()
	vim.g.lasttab = 1

	vim.api.nvim_create_autocmd({ 'TabLeave' }, {
		callback = function()
			vim.g.lasttab = vim.fn.tabpagenr()
		end,
		-- nested = true,
	})

	vim.cmd [[
		noremap <C-T>t- :execute "tabn ".g:lasttab<CR>
		noremap <C-T>k :tabprev<CR>
		noremap <C-T>j :tabnext<CR>
		noremap <C-T>h :tabmove -<CR>
		noremap <C-T>l :tabmove +<CR>
		noremap <C-T>n :tabnew<CR>
		noremap <C-T>x :tabclose<CR>
		" noremap [t :tabprev<CR>
		" noremap ]t :tabnext<CR>

		" switch tab in normal mode
		" noremap <leader>1 1gt
		" noremap <leader>2 2gt
		" noremap <leader>3 3gt
		" noremap <leader>4 4gt
		" noremap <leader>5 5gt
		" noremap <leader>6 6gt
		" noremap <leader>7 7gt
		" noremap <leader>8 8gt
		" noremap <leader>9 9gt
		" noremap <leader>0 :tablast<CR>
	]]
end

return M
