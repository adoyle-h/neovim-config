local util = require('adoyle-neovim-config.util')

-- @class ConfigManager
-- @field config {table} The config for ConfigManager
-- @field userSetup {table} The opts of ConfigManager.setup(opts)
local CM = { --
	config = {},
	userSetup = {},
	plugins = {},
	pluginOpts = {},
}

function CM.setConfig(conf)
	local defaultConfigFn = require('adoyle-neovim-config.config.default')
	local defaultColor = require('adoyle-neovim-config.config.color')

	local color = util.merge(defaultColor, conf.color)
	local defaultConfig = defaultConfigFn(color)
	local config = util.merge(defaultConfig, conf)

	config._revision = CM.config._revision and (CM.config._revision + 1) or 1

	if #config.proxy.github > 0 then
		util.proxyGithub = function(url)
			return CM.config.proxy.github .. url
		end
	end

	CM.config = config
	return CM
end

function CM.setup(opts)
	CM.userSetup = vim.deepcopy(opts)
	CM.plugins = opts.plugins or {}
	CM.pluginOpts = opts.pluginOpts or {}
	CM.setConfig(opts.config)
	return CM
end

return CM
