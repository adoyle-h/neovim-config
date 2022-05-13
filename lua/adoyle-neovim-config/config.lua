local util = require('adoyle-neovim-config.util')

-- @class Config
-- @field global {table} The config for ADoyleNeovimConfig
-- @field setupOpts {table} The opts of ADoyleNeovimConfig.setup(opts)
local config = {
	global = require('adoyle-neovim-config.config.default'),
	setupOpts = nil,
}

function config.setGlobal(c)
	config.global = util.merge(config.global, c)
	config.global._revision = config.global._revision and (config.global._revision + 1) or 1

	if config.global.proxy.github then
		util.proxyGithub = function(url) return config.global.proxy.github .. url end
	else
		util.proxyGithub = function(url) return url end
	end
end

function config.setSetupOpts(opts)
	config.setupOpts = util.merge({}, opts)
	config.setGlobal(opts.config)
	return config.setupOpts
end

return config
