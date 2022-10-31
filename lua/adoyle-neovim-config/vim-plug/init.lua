-- The packer.nvim is terrible. Use vim-plug! https://github.com/junegunn/vim-plug
local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')
local globals = require('adoyle-neovim-config.vim-plug.globals')
local normalizeOpts = require('adoyle-neovim-config.vim-plug.normalize')
local Plug = require('adoyle-neovim-config.vim-plug.plug')
local consts = require('adoyle-neovim-config.consts')

local levelMap = consts.log.levelMap
local set_keymap = vim.keymap.set

local plugMap, plugs, userPlugins = globals.plugMap, globals.plugs, globals.userPlugins
local P = { plugs = plugs, plugMap = plugMap, userPlugins = userPlugins, configFn = nil }

function P.setup(opts)
	set_keymap('n', '<SPACE>P', ':PlugStatus<CR>', { desc = 'Show Plugin Status' })

	local vimPlugConf = CM.config.pluginManager
	vim.g.plug_threads = vimPlugConf.threads
	vim.g.plug_timeout = vimPlugConf.timeout
	vim.g.plug_retries = vimPlugConf.retries
	vim.g.plug_shallow = vimPlugConf.shallow
	vim.g.plug_window = vimPlugConf.window
	vim.g.plug_pwindow = vimPlugConf.pwindow
	-- Use git proxy for fast downloading
	vim.g.plug_url_format = util.proxyGithub 'https://github.com/%s'

	P.configFn = opts.configFn

	for _, p in pairs(opts.userPlugins or {}) do
		local plugOpts = normalizeOpts(p)
		userPlugins[plugOpts.id] = plugOpts
	end
end

function P.start()
	vim.call('plug#begin', CM.config.pluginManager.pluginDir)
end

function P.fin()
	for _, p in pairs(userPlugins) do if p then P.Plug(p) end end

	vim.call('plug#end')
end

local function addPending(pendings, plug)
	if plug.disable then
		if plug.uninstalled then
			P.notify(
				string.format('Plug "%s" has not installed. Try ":PlugInstall" to install it.', plug.id), 'warn')
		elseif plug.reason then
			P.notify(string.format('Plug "%s" has been loaded but not setup. Because %s.', plug.id,
				plug.reason), 'warn')
		end
	else
		Plug.mergePlugConfig(CM.config, plug)
		pendings[#pendings + 1] = plug
	end
end

local function setNotify()
	local notify

	-- if pcall(require, 'notify') then
	if false then
		notify = function(msg, level)
			vim.schedule(function()
				vim.notify(msg, level)
			end)
		end
	else
		notify = function(msg, level)
			print(string.format('[%s] %s', levelMap[level] or level or 'INFO', msg))
		end
	end

	P.notify = notify

	return notify
end

function P.run()
	local notify = setNotify()
	local config = CM.config
	local pendings = {}

	for _, plug in pairs(plugs) do addPending(pendings, plug) end

	if P.configFn then
		local config2 = P.configFn(config) or {}
		for key, value in pairs(config2) do config[key] = util.merge(config[key], value) end
	end

	for _, plug in pairs(pendings) do
		local ok, msg = pcall(Plug.executePlugOptions, plug, config)
		if not ok then notify(string.format('[Plug: %s] %s', plug.id, msg), 'warn') end
	end
end

-- Plug Load plugin of vim-plug
-- @useage Plug(repo[, opts])
-- @useage Plug({repo, opts...})
--
-- @param repo {string}
--   repo='<github-user>/<repo-name>' such as 'nvim-lua/plenary.nvim', or
--   repo='name' without '/'
-- @param opts {table} Its fields are compatible with https://github.com/junegunn/vim-plug#plug-options
--
-- @example See examples at ./lua/adoyle-neovim-config/plugins.lua
P.Plug = function(repo, opts)
	Plug.usePlug(globals, repo, opts)
end

-- @type {function(path)} Load builtin plugin by filepath which relative lua directory.
P.LoadPluginFile = function(path)
	local opts = require('adoyle-neovim-config.' .. path)
	local userPluginOpts = plugMap[opts[1]]
	opts = util.merge(opts, userPluginOpts)
	P.Plug(opts)
end

P.isPlugDisabled = function(id)
	local p = plugMap[id]
	if p then
		return p.disable
	else
		return true
	end
end

return P
