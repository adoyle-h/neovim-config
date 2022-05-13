-- The packer.nvim is terrible. Use vim-plug! https://github.com/junegunn/vim-plug

local util = require('adoyle-neovim-config.util')
local config = require('adoyle-neovim-config.config')

local fn = vim.fn
local loadPlug = vim.fn['plug#']
local plugs = {}
local unloadRepos = {}

local plugOptsKeys = {
	cmd = 'on',
	run = 'do',
}

local function parsePlugOpts(plugin)
	local opts = util.merge({}, plugin)

	for alias, key in pairs(plugOptsKeys) do
		if plugin[alias] ~= nil then
			opts[key] = plugin[alias]
		end
	end

	return opts
end

local function endsWith(str, suffix)
	return str:sub(- #suffix) == suffix
end

local function getPlugFolderName(repo)
	local s = fn.split(repo, '/')
	local name = s[#s]
	if endsWith(name, '.git') then
		name = name:sub(0, -5)
	end
	return name
end

-- The structure of M should be compatible with packer.nvim Plug and vim-plug Plug
-- @param M {string|table} See packer.nvim Plug: https://github.com/wbthomason/packer.nvim#specifying-plugins
-- @param [opts] {table}
-- @useage Plug(repo[, opts])
-- @useage Plug({repo, opts...})
-- The repo is a string. Example: 'nvim-lua/plenary.nvim'
local function usePlug(repo, opts)
	local type = type(repo)

	if not opts then
		if type == 'string' then
			loadPlug(repo)
			opts = {}
		elseif type == 'table' then
			opts = repo
			repo = table.remove(opts, 1)
			opts.repo = repo
		else
			error(fn.printf('Invalid Plug Type: %s', type))
		end
	end

	local userPluginOpts = config.global.plugins[repo]
	opts = util.merge(opts, userPluginOpts)

	if opts.disable == true then
		-- disbale current and required plugs
		return
	end

	-- load dependencies first
	if opts.requires then
		for _, dep in pairs(opts.requires) do
			usePlug(dep)
		end
	end

	-- handle current mod
	local plugOpts = parsePlugOpts(opts)

	if opts.setup then
		-- Run setup before plugin is loaded.
		opts.setup()
	end

	if repo and #repo > 0 then
		if #plugOpts > 0 then
			loadPlug(repo, plugOpts)
		else
			loadPlug(repo)
		end

		-- If plug is uninstalled, do not continue
		local foldname = getPlugFolderName(repo)
		if not util.exist(P.pluginDir .. '/' .. foldname) then
			table.insert(unloadRepos, repo)
			return
		end

		table.insert(plugs, opts)
	else
		-- repo equals '' or nil or false or []
		table.insert(plugs, opts)
	end
end

local P = {
	pluginDir = nil,
}

function P.setup()
	vim.keymap.set('n', '<SPACE>P', '<cmd>:PlugStatus<CR>', { noremap = false, desc = 'Show Plugin Status' })

	vim.g.plug_timeout = 30
	-- Use git proxy for fast downloading
	vim.g.plug_url_format = util.proxyGithub 'https://github.com/%s'

	local NVIM_HOME = fn.stdpath('config')
	P.pluginDir = NVIM_HOME .. '/plugged' -- All plugins put in this directory

	-- See https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
	if not util.exist(NVIM_HOME .. '/autoload/plug.vim') then
	vim.cmd(fn.printf(
				'silent !curl -fLo %s --create-dirs %s',
				NVIM_HOME .. '/autoload/plug.vim',
				util.proxyGithub 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
			 ))
	vim.cmd 'autocmd VimEnter * PlugInstall --sync | source $MYVIMRC'
	end
end

function P.start()
	vim.call('plug#begin', P.pluginDir)
end

function P.fin()
	vim.call('plug#end')

	for _, M in pairs(plugs) do
		if type(M.config) == 'function' then
			M.config()
		end
	end

	local notify = vim.notify and vim.notify or print
	for _, repo in pairs(unloadRepos) do
		notify(fn.printf('[WARN] Plug "%s" has not installed. Try ":PlugInstall" to install it.', repo))
	end
end

function P.Plug(...)
	usePlug(...)
end

return P
