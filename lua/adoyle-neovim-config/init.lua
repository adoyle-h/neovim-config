local config = require('adoyle-neovim-config.config')
local util = require('adoyle-neovim-config.util')

local M = {
	util = util,
}

M.setup = function(opts)
	config.setGlobal(opts.config)
	M.config = config.getGlobal()

	require('adoyle-neovim-config.fix-lua')
	require('adoyle-neovim-config.basic')
	require('adoyle-neovim-config.plugins')
end

return M
