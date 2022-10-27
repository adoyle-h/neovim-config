local util = require('adoyle-neovim-config.util')

-- @class ConfigManager
-- @field config {table} The config for ConfigManager
local CM = { --
	config = {},
}

function CM.setup(conf)
	local defaultConfigFn = require('adoyle-neovim-config.config.default')
	local defaultColors = require('adoyle-neovim-config.config.colors')

	local colors = util.merge(defaultColors, conf.colors)
	local defaultConfig = defaultConfigFn(colors)
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

return CM
