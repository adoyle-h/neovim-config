local M = {
	nil,
	desc = 'General Keymaps',
	disable = false,
}


function M.config()
	local keymap = vim.keymap.set

	keymap('n', '<F1>', '<Esc>', {
		noremap = true, silent = true,
		desc = 'Prevent <F1> key from opening system help window. You can use ":h" to open vim help window',
	})

	keymap('n', 'Q', '<NOP>', { noremap = true, silent = true, desc = 'disable Ex mode' })

	keymap('n', 't', 'xp', { noremap = true, silent = true, desc = 'swap adjacent characters' })

	keymap('i', 'jk', '<Esc>', { noremap = true, silent = true, desc = 'Exit from input mode' })

	keymap('t', 'kj', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit from terminal mode' })

	keymap('n', '<leader>sa', 'ggVG', { noremap = true, silent = true, desc = 'select all' })

	keymap('v', '.', ':normal .<CR>', { noremap = true, silent = true, desc = 'enable . command in visual mode' })

	keymap('n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'remap U to <C-r> for easier redo' })

	keymap('n', '<M-g>', ':echo expand("%:p")<CR>', { noremap = true, silent = true, desc = 'indent line' })

	-- Jump Keymap --
	-- Because <C-i> is synonymous to <Tab> in nvim. I don't know the reason.
	-- :h tui-input
	-- nnoremap <C-i> <C-i>
	keymap('n', 'g]', '<C-i>', { noremap = true, silent = true, desc = 'jump reverse to previous cursor position' })
	keymap('n', 'g[', '<C-o>', { noremap = true, silent = true, desc = 'jump to previous cursor position' })

	-- Toggles Keymap --
	keymap('n', '<leader>N', function()
		vim.opt.relativenumber = not vim.o.relativenumber
	end, { noremap = true, silent = true, desc = 'toggle relative/absolute number gutter' })

	keymap('n', '<leader>L', ':set relativenumber! number!<CR>', {
		noremap = true, silent = true, desc = 'toggle linenumber gutter',
	})

	keymap('n', '<leader>l', ':set list!<CR>', {
		noremap = true, silent = true, desc = 'toggle invisible characters',
	})

	keymap('n', '<leader>so', ':let &scrolloff=999-&scrolloff<CR>', {
		noremap = true, silent = true, desc = 'toggle scrolloff',
	})

	keymap('n', '<M-s>', ':set invspell<CR>', {
		noremap = true, silent = true, desc = 'toggle spell-checking',
	})
end

return M
