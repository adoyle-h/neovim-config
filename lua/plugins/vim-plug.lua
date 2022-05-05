-- The packer.nvim is terrible. Use vim-plug! https://github.com/junegunn/vim-plug

vim.g.plug_timeout = 30
-- Use git proxy for fast downloading
vim.g.plug_url_format	= 'https://ghproxy.com/https://github.com/%s'
-- All plugins put in this directory
local pluginDir = vim.fn.stdpath('config') .. '/plugged'

local Plug = vim.fn['plug#']
local mods = {}

local function parsePlugOpts(M)
	local opts = {}

	if M.run then
		opts['do'] = M.run
	end

	if M.on then
		opts['on'] = M.on
	end

	if M.cmd then
		opts['on'] = M.cmd
	end

	return opts
end

-- The structure of M should be compatible with packer.nvim Plug
-- @param M {string|table} See packer.nvim Plug: https://github.com/wbthomason/packer.nvim#specifying-plugins
local function useMod(M)
	if type(M) == 'string' then
		Plug(M)
		return
	end

	-- M is table

	if M.disable == true then
		return
	end

	-- load dependencies first
	if M.requires then
		for _, dep in pairs(M.requires) do
			useMod(dep)
		end
	end

	-- handle current mod
	local repo = M[1]
	local repoOpts = parsePlugOpts(M)

	if M.setup then
		-- Run setup before plugin is loaded.
		M.setup()
	end

	if #repoOpts > 0 then
		Plug(repo, repoOpts)
	else
		Plug(repo)
	end

	table.insert(mods, M)
end

local P = {}

function P.Load(path)
	local M = require(path)
	useMod(M)
end

function P.start()
	vim.call('plug#begin', pluginDir)
end

function P.fin()
	vim.call('plug#end')

	for _, M in pairs(mods) do
		if type(M.config) == 'function' then
			M.config()
		end
	end
end

P.Plug = Plug

return P
