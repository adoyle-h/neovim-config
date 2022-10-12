local M = { disable = true }

M.config = function()
	vim.g.lasttab = 1

	vim.api.nvim_create_autocmd({ 'TabLeave' }, {
		callback = function()
			vim.g.lasttab = vim.fn.tabpagenr()
		end,
		-- nested = true,
	})
end

local opts = { noremap = true }

M.keymaps = {

	{ 'n', '<C-T>t-', ':execute "tabn ".g:lasttab<CR>', opts },
	{ 'n', '<C-T>k', ':tabprev<CR>', opts },
	{ 'n', '<C-T>j', ':tabnext<CR>', opts },
	{ 'n', '<C-T>h', ':tabmove -<CR>', opts },
	{ 'n', '<C-T>l', ':tabmove +<CR>', opts },
	{ 'n', '<C-T>n', ':tabnew<CR>', opts },
	{ 'n', '<C-T>x', ':tabclose<CR>', opts },

	-- switch tab in normal mode
	{ 'n', '<leader>1', '1gt', opts },
	{ 'n', '<leader>2', '2gt', opts },
	{ 'n', '<leader>3', '3gt', opts },
	{ 'n', '<leader>4', '4gt', opts },
	{ 'n', '<leader>5', '5gt', opts },
	{ 'n', '<leader>6', '6gt', opts },
	{ 'n', '<leader>7', '7gt', opts },
	{ 'n', '<leader>8', '8gt', opts },
	{ 'n', '<leader>9', '9gt', opts },
	{ 'n', '<leader>0', ':tablast<CR>', opts },

}

return M
