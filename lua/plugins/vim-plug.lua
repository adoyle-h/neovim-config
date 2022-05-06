-- The packer.nvim is terrible. Use vim-plug! https://github.com/junegunn/vim-plug

local fn = vim.fn
local NVIM_HOME = vim.fn.stdpath('config')

-- See https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if fn.empty(fn.glob(NVIM_HOME .. '/autoload/plug.vim')) > 0 then
	vim.cmd(fn.printf(
		'silent !curl -fLo %s --create-dirs %s',
		NVIM_HOME .. '/autoload/plug.vim',
		'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	))
	vim.cmd 'autocmd VimEnter * PlugInstall --sync | source $MYVIMRC'
end


vim.g.plug_timeout = 30
-- Use git proxy for fast downloading
vim.g.plug_url_format	= 'https://ghproxy.com/https://github.com/%s'
-- All plugins put in this directory
local pluginDir = NVIM_HOME .. '/plugged'

local Plug = vim.fn['plug#']
local mods = {}

local plugOptsKeys = {
	cmd = 'on',
	run = 'do',
	'branch',
	'for',
}

local function parsePlugOpts(M)
	local opts = {}

	for alias, key in pairs(plugOptsKeys) do
		if M[key] then
			opts[key] = M[key]
		end

		if (type(alias) == 'string') then
			-- Support alias. {alias = key}
			if M[alias] then
				opts[key] = M[alias]
			end
		end
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
