local config = require('adoyle-neovim-config.config')

local M = {}

M.setup = setmetatable({}, {
	__call = function(self, opts)
		opts = opts or {}

		config.set_global(opts.config)
		require('adoyle-neovim-config.fix-lua')
		require('adoyle-neovim-config.basic')
		require('adoyle-neovim-config.plugins')
	end,
})

return M
