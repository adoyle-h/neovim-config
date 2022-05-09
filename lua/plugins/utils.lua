local M = {
	nil,
	desc = 'Personal utility functions and commands',
	disable = false,
}

function M.config()
	local command = vim.api.nvim_create_user_command

	-- command('InspectVar', function(opts)
	--   vim.notify(vim.inspect(opts.fargs[1]))
	-- end, { desc = 'Print lua variable', nargs = 1 })

	command('GetWinConfig', function()
		vim.notify(vim.inspect(vim.api.nvim_win_get_config(0)))
	end, { desc = 'Print current window config' })

	command('Q', ':q!', { desc = 'quit current buffer without saving' })
	command('Qa', ':qa!', { desc = 'quit all buffers without saving' })
	command('F', ':Neoformat', { desc = 'format code' })
	command('ClearCRLF', ':%s/\
//g', { desc = 'Clear ^M' })
	command('Reload', ':source ~/.config/nvim/init.vim', { desc = 'Reload Nvim Config' })
	command('CD', ':lcd %:p:h', { desc = 'Change PWD in current buffer' })

	command('FixLineBreak', function()
		vim.cmd [[
			e ++ff=dos
			set ff=unix
			w
		]]
	end, {})

	command('ProfileStart', function()
		vim.cmd [[
			profile start profile.log
			profile func *
			profile file *
		]]
	end, { desc = 'ProfileStart/ProfileEnd' })

	command('ProfileEnd', function()
		vim.cmd ':profile pause'
	end, { desc = 'ProfileStart/ProfileEnd' })
end

return M
