-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide
local CM = require('adoyle-neovim-config.config')
local util = require('adoyle-neovim-config.util')
local P = require('adoyle-neovim-config.vim-plug')

-- @class ADoyleNeovimFramework
-- @field util {table}
--
-- @field Plug {function}  Load plugin of vim-plug
--   @useage Plug(repo[, opts])
--   @useage Plug({repo, opts...})
--   The repo is a string. Example: 'nvim-lua/plenary.nvim'
--   The opts is a table. Support https://github.com/junegunn/vim-plug#plug-options
--   See examples at ./lua/adoyle-neovim-config/plugins.lua
--
-- @field P {function}
-- @field CM {ConfigManager}
local M = { CM = CM, util = util, Plug = P.Plug, P = P }

-- @param [opts] {table}
-- @param [opts.config] {table}
M.setup = function(opts)
	CM.setup(opts)

	require('adoyle-neovim-config.fix-lua')

	P.setup()
	P.start()
	require('adoyle-neovim-config.plugins')
	for _, plugin in pairs(CM.config.plugins) do
		if type(plugin) == 'function' then
			plugin(P.Plug)
		else
			P.Plug(plugin)
		end
	end
	P.fin()
end

return M
