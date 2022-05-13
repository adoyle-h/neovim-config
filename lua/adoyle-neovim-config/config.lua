local util = require('adoyle-neovim-config.util')

local config = {
	global = require('adoyle-neovim-config.config.default')(),
}

function config.setGlobal(c)
	config.global = util.merge(c, config.global)
	config.global._revision = config.global._revision and (config.global._revision + 1) or 1
end

function config.getGlobal()
	return config.global
end

return config
