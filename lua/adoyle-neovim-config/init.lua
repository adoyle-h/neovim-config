-- NOTE: Current Lua version is 5.1 in neovim 0.8
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide
local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')
local consts = require('adoyle-neovim-config.consts')
local PM = require('adoyle-neovim-config.plugin-manager')
local F = require('adoyle-neovim-config.framework')
local FT = require('adoyle-neovim-config.filetype')
local dynamic = require('adoyle-neovim-config.plugins.completion.dynamic.source')

-- @class ADoyleNeovimConfig
-- @field util {table}
-- @field CM {ConfigManager}
F.CM = CM
F.PM = PM
F.FT = FT
F.consts = consts
F.util = util
F.cmp = { add = dynamic.add }

local function setupImpatient(config)
	local impatient = config.impatient

	if impatient.enable then
		local isNew = util.ensurePkg { --
			url = impatient.src,
			dist = impatient.dist,
		}

		if isNew then util.packadd(impatient.dist) end

		require(impatient.pkgName)
	end
end

local function someFixes()
	-- Fix undefined table.unpack
	-- :lua print(_VERSION) returns "Lua 5.1"
	-- See https://github.com/neovim/neovim/blob/v0.7.0/runtime/lua/vim/compat.lua
	table.unpack = unpack

	vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'grey' }) -- THe initial float window is too ugly
end

-- @param [opts] {table}
-- @param [opts.config] {table}
-- @param [opts.configFn] {function(config):table}
-- @param [opts.onlyPlugins] {string[]|nil}
--   It's useful for debug. Defaults to nil.
--   If set empty table, all builtin and user-defined plugins are disabled.
--   If set non-empty table, only these plugins are not disabled.
-- @param [opts.plugins] {table|function(config)}
F.setup = function(opts)
	someFixes()

	CM.setup(opts.config or {})
	local config = CM.config

	if config.global then _G[config.global] = F end

	-- Do not set mapleader in vim-options plugin. Because user may use `onlyPlugins` to disable all plugins.
	vim.g.mapleader = config.leaderKey

	setupImpatient(config)
	PM.setup(opts)
	FT.setup()
end

return F
