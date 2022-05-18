-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide

local C = require('adoyle-neovim-config.config')
local util = require('adoyle-neovim-config.util')
local P = require('adoyle-neovim-config.vim-plug')
-- local P = require('adoyle-neovim-config.paq')


-- @class ADoyleNeovimConfig
-- @field util {table}
--
-- @field Plug {function}  Load plugin of vim-plug
--   @useage Plug(repo[, opts])
--   @useage Plug({repo, opts...})
--   The repo is a string. Example: 'nvim-lua/plenary.nvim'
--   The opts is a table. Support https://github.com/junegunn/vim-plug#plug-options
--   See examples at ./lua/adoyle-neovim-config/plugins.lua
--
-- @field config {Config}
local M = {
	config = nil,
	util = util,
	Plug = P.Plug,
	P = P,
}

-- @param opts.config {table}
-- @param opts.plugins {function(ADoyleNeovimConfig)} You can load plugins by yourself. See examples at ./lua/adoyle-neovim-config/plugins.lua
M.setup = function(opts)
	C.setSetupOpts(opts)
	local config = C.global
	M.config = config

	require('adoyle-neovim-config.fix-lua')
	require('adoyle-neovim-config.basic')

	P.setup()
	P.start()
	require('adoyle-neovim-config.plugins')
	for _, plugin in pairs(config.plugins) do
		if type(plugin) == 'function' then
			plugin(P.Plug)
		else
			P.Plug(plugin)
		end
	end
	P.fin()
end

return M
