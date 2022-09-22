local M = { nil, desc = 'Set autocmd callbacks', disable = false }

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
