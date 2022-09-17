local util = require('adoyle-neovim-config.util')

-- @class ConfigManager
-- @field config {table} The config for ConfigManager
-- @field userSetup {table} The opts of ConfigManager.setup(opts)
local ConfigManager = {
	config = {},
	userSetup = {},
}

function ConfigManager.setConfig(conf)
	local defaultConfigFn = require('adoyle-neovim-config.config.default')
	local defaultColor = require('adoyle-neovim-config.config.color')

	local color = util.merge(defaultColor, conf.color)
	local defaultConfig = defaultConfigFn(color)
	local config = util.merge(defaultConfig, conf)

	config._revision = ConfigManager.config._revision and (ConfigManager.config._revision + 1) or 1

	if #config.proxy.github > 0 then
		util.proxyGithub = function(url) return ConfigManager.config.proxy.github .. url end
	end

	ConfigManager.config = config
	return ConfigManager
end

function ConfigManager.setup(opts)
	ConfigManager.userSetup = opts
	ConfigManager.setConfig(opts.config)
	return ConfigManager
end

return ConfigManager
