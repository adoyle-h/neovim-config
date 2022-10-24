-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide
local CM = require('adoyle-neovim-config.config')
local util = require('adoyle-neovim-config.util')
local P = require('adoyle-neovim-config.vim-plug')
local F = require('adoyle-neovim-config.framework')
local FT = require('adoyle-neovim-config.filetype')
local dynamic = require('adoyle-neovim-config.plugins.completion.dynamic.source')

require('adoyle-neovim-config.fix-lua')

-- @class ADoyleNeovimConfig
-- @field util {table}
-- @field CM {ConfigManager}
F.CM = CM
F.util = util
F.cmp = { add = dynamic.add }

local function setGlobal()
	local config = CM.config
	if config.global then _G[config.global] = F end
end

-- @param [opts={}] {table}
-- @param [opts.config] {table}
-- @param [opts.configFn] {function(config):table}
-- @param [opts.noPlugins=false] {boolean} If true, all builtin and user-defined plugins will not be loaded
-- @param [opts.plugins] {table|function(config)}
F.setup = function(opts)
	CM.setup(opts.config or {})

	setGlobal()

	if not opts.noPlugins then
		P.setup { userPlugins = opts.plugins, configFn = opts.configFn }
		P.start()

		require('adoyle-neovim-config.plugins')
		for _, plugin in pairs(opts.plugins or {}) do
			-- Append user plugins. More examples at ./lua/adoyle-neovim-config/plugins.lua
			P.Plug(plugin)
		end

		P.fin()
		P.run()
	end

	FT.setup()
end

return F
