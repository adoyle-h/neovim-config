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

local plug = vim.fn['plug#']
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

-- The structure of M should be compatible with packer.nvim Plug and vim-plug Plug
-- @param M {string|table} See packer.nvim Plug: https://github.com/wbthomason/packer.nvim#specifying-plugins
-- @param [Opts] {table}
-- @useage: useMod(string)
-- @useage: useMod(string, opts)
-- @useage: useMod({string, opts...})
local function useMod(repo, opts)
	local type = type(repo)

	if not opts then
		if type == 'string' then
			plug(repo)
			return
		elseif type == 'table' then
			opts = repo
			repo = table.remove(opts, 1)
			opts.repo = repo
		else
			error(fn.printf('Invalid Plug Type: %s', type))
		end
	end

	if opts.disable == true then
		-- disbale current and required plugs
		return
	end

	-- load dependencies first
	if opts.requires then
		for _, dep in pairs(opts.requires) do
			useMod(dep)
		end
	end

	-- handle current mod
	local repoOpts = parsePlugOpts(opts)

	if opts.setup then
		-- Run setup before plugin is loaded.
		opts.setup()
	end

	-- Allow repo equals '' or nil or false
	if repo and #repo > 0 then
		if #repoOpts > 0 then
			plug(repo, repoOpts)
		else
			plug(repo)
		end
	end

	table.insert(mods, opts)
end

local P = {}

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

function P.Plug(...)
	useMod(...)
end

function P.Load(path)
	useMod(require(path))
end

return P
