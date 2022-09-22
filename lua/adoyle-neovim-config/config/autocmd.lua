return {
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
}
