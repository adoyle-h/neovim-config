-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide

local config = require('adoyle-neovim-config.config')
local util = require('adoyle-neovim-config.util')
local P = require('adoyle-neovim-config.vim-plug')


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
}

-- @param opts.config {table}
-- @param opts.plugins {function(ADoyleNeovimConfig)} You can load plugins by yourself. See examples at ./lua/adoyle-neovim-config/plugins.lua
M.setup = function(opts)
	config.setSetupOpts(opts)
	M.config = config.global

	require('adoyle-neovim-config.fix-lua')
	require('adoyle-neovim-config.basic')

	P.start()
	require('adoyle-neovim-config.plugins')
	if opts.plugins then opts.plugins(M) end
	P.fin()
end

return M
