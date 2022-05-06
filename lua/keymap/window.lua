local M = {
	nil,
	desc = 'Window Keymaps',
	disable = false,
}

function M.config()
	vim.cmd [[
		" shortcut to save current buffer
		noremap <leader>w :w<CR>
		" shortcut to quit current window
		noremap <leader>q :close<CR>
		" shortcut to quit current tab
		noremap <leader>Q :tabclose<CR>
		" shortcut to refresh current window
		noremap <leader>e :e<CR>

		noremap <C-W>N :vnew<CR>
		nmap <C-W>h <C-W>h
		nmap <C-W>j <C-W>j
		nmap <C-W>k <C-W>k
		nmap <C-W>l <C-W>l
		nmap <C-W>H <C-W>5<<C-W>
		nmap <C-W>J <C-W>3+<C-W>
		nmap <C-W>K <C-W>3-<C-W>
		nmap <C-W>L <C-W>5><C-W>
		nmap <C-W>< <C-W><<C-W>
		nmap <C-W>+ <C-W>+<C-W>
		nmap <C-W>- <C-W>-<C-W>
		nmap <C-W>> <C-W>><C-W>
		nnoremap <C-W><C-L> <C-W>L
		nnoremap <C-W><C-H> <C-W>H
		nnoremap <C-W><C-J> <C-W>J
		nnoremap <C-W><C-K> <C-W>K
		noremap <C-W>s\ <C-W>s
		noremap <C-W>s\| <C-W>v
		noremap <C-W>\ :new<CR>
		noremap <C-W>\| :vnew<CR>
		noremap <C-W>x <C-W>q
		noremap <C-W>! <C-W>T
		nmap <C-W>o <C-W>w<C-W>
		nmap <C-W>O <C-W>W<C-W>
	]]
end

return M
