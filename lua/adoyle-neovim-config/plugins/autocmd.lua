local M = { nil, desc = 'Set autocmd callbacks' }

M.defaultConfig = {
	'autocmd',
	{
		maps = {
			js = function()
				-- vim.cmd 'set isk-=.'
				vim.opt_local.isk:remove{ '.' }
			end,

			jsx = function()
				-- vim.cmd 'set isk-=.'
				vim.opt_local.isk:remove{ '.' }
			end,

			crontab = function()
				vim.opt_local.backup = false
				vim.opt_local.writebackup = false
			end,

			['null-ls-info'] = function()
				vim.api.nvim_win_set_config(0, { border = 'rounded', height = 30 })
			end,
		},
	},
}

function M.config()
	local maps = require('adoyle-neovim-config.config').config.autocmd.maps

	vim.api.nvim_create_autocmd({ 'FileType' }, {
		callback = function(args)
			local fn = maps[args.match]
			if fn then fn() end
		end,
	})
end

return M
