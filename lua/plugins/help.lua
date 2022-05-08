local M = {
	nil,
	desc = 'Show Help',
	disable = false,
}

function M.config()
	vim.api.nvim_set_keymap('n', '<SPACE>?', '', {
		callback = function()
			vim.notify [[
<leader> key = ';'
<C-W>q = close window
			]]
		end
	})
end

return M
