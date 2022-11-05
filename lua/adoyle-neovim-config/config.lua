local util = require('adoyle-neovim-config.util')

-- @class ConfigManager
-- @field config {table} The config for ConfigManager
local CM = { --
	config = {},
}

local function makeProxyGithub(prefix)
	return function(url)
		return prefix .. url
	end
end

function CM.setup(conf)
	local defaultConfigFn = require('adoyle-neovim-config.config.default')
	local defaultColors = require('adoyle-neovim-config.config.colors')

	local colors = util.merge(defaultColors, conf.colors)
	local defaultConfig = defaultConfigFn(colors)
	local config = util.merge(defaultConfig, conf)

	config._revision = CM.config._revision and (CM.config._revision + 1) or 1

	local proxyGithub = config.proxy.github
	if type(proxyGithub) == 'string' and #proxyGithub > 0 then
		if not vim.endswith(proxyGithub, '/') then
			proxyGithub = proxyGithub .. '/'
			config.proxy.github = proxyGithub
		end
		util.proxyGithub = makeProxyGithub(proxyGithub)
	end

	CM.config = config
	return CM
end

return CM
