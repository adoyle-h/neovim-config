local M = {
	nil,
	desc = 'The settings of nvim embeded terminal. See :h terminal',
	disable = false,
	requires = {},
}

local util = require('adoyle-neovim-config.util')

local function trim(s)
	return (string.gsub(s, '^%s*(.-)%s*$', '%1'))
end

local function send(v)
	local term_buf_id = -1

	for _, buf_id in pairs(vim.fn.tabpagebuflist()) do
		local buf_type = vim.api.nvim_buf_get_option(buf_id, 'buftype')

		if buf_type == 'terminal' then
			term_buf_id = buf_id
			local text = ''

			if v then
				-- Get selected lines
				text = util.getVisualSelection(true)
			else
				-- Get current line
				text = vim.api.nvim_get_current_line()
			end

			local chan_id = vim.api.nvim_buf_get_var(term_buf_id, 'terminal_job_id')

			vim.api.nvim_chan_send(chan_id, trim(text) .. '\n')
		end
	end
end

function M.config()
	vim.api.nvim_create_autocmd({ 'TermOpen' }, {
		callback = function()
			vim.wo.number = false
			vim.wo.rnu = false
		end,
	})

	-- Config keymaps
	local keymap = vim.keymap.set

	keymap('t', 'jk', '<C-\\><C-n>',
		{ noremap = true, silent = true, desc = 'Exit from terminal mode' })

	keymap('n', '<leader>tt', function()
		local cmd = vim.fn.input { prompt = 'New Terminal: ', default = 'bash' }
		vim.cmd.vsplit('term://' .. cmd)
	end, { noremap = true, silent = true, desc = 'Create terminal window' })

	keymap('n', '<leader>ts', send, { noremap = true, silent = true, desc = 'Send text to terminal' })
	keymap('x', '<leader>ts', function()
		send(true)
	end, { noremap = true, silent = true, desc = 'Send text to terminal' })

end

return M
