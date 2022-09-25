local M = { 'mfussenegger/nvim-dap', requires = {} }

M.signs = {
	{ 'DapBreakpoint', { text = 'B' } },
	{ 'DapBreakpointCondition', { text = 'C' } },
	{ 'DapLogPoint', { text = 'L' } },
	{ 'DapStopped', { text = '→' } },
	{ 'DapBreakpointRejected', { text = 'R' } },
}

M.keymaps = function()
	local dap = require('dap')

	return {
		{ 'n', '<F9>', dap.continue, { silent = true } },
		{ 'n', '<F10>', dap.step_over, { silent = true } },
		{ 'n', '<F11>', dap.step_into, { silent = true } },
		{ 'n', '<F12>', dap.step_out, { silent = true } },
		{ 'n', '<leader>db', dap.toggle_breakpoint, { silent = true } },

		{
			'n',
			'<leader>dB',
			function()
				dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
			end,
			{ silent = true },
		},

		{
			'n',
			'<leader>dp',
			function()
				dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
			end,
			{ silent = true },
		},

		{ 'n', '<leader>dr', dap.repl.open, { silent = true } },
		{ 'n', '<leader>dl', dap.run_last, { silent = true } },
	}
end

return M
