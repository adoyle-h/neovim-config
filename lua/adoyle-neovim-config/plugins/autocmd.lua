local M = {
	nil,
	desc = 'Set autocmd callbacks',
	disable = false,
	-- requires = {},
	-- ['for'] = '',
}

local maps = {
	js = function()
		-- vim.cmd 'set isk-=.'
		vim.opt_local.isk:remove { '.' }
	end,

	jsx = function()
		-- vim.cmd 'set isk-=.'
		vim.opt_local.isk:remove { '.' }
	end,

	crontab = function()
		vim.opt_local.backup = false
		vim.opt_local.writebackup = false
	end,

	['lsp-installer'] = function()
		-- Set border for LSPInstaller popup window
		vim.api.nvim_win_set_config(0, { border = 'rounded' })
	end,

	['null-ls-info'] = function()
		-- Set border for LSPInstaller popup window
		vim.api.nvim_win_set_config(0, { border = 'rounded', height = 30 })
	end,

	['lspinfo'] = function()
		-- Set border for LSPInstaller popup window
		vim.api.nvim_win_set_config(0, { border = 'rounded' })
	end,
}

function M.config()
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = { '*' },
		callback = function(args)
			local fn = maps[args.match]
			if fn then fn() end
		end,
	})

end

return M
