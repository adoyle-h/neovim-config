-- The packer.nvim is terrible. Use vim-plug! https://github.com/junegunn/vim-plug
local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')
local globals = require('adoyle-neovim-config.vim-plug.globals')
local normalizeOpts = require('adoyle-neovim-config.vim-plug.normalize')
local Plug = require('adoyle-neovim-config.vim-plug.plug')

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
	for _, p in pairs(userPlugins) do if p then Plug.usePlug(p) end end

	vim.call('plug#end')
end

local function addPending(pendings, plug)
	if plug.disable then return end

	local unloadRequired = false

	for _, required in pairs(plug.requires or {}) do
		local requiredPlugRepo
		if type(required) == 'string' then
			requiredPlugRepo = required
		else
			requiredPlugRepo = required[1]
		end

		local reqP = plugMap[requiredPlugRepo]
		if reqP then
			if reqP.disable then
				unloadRequired = reqP
				break
			end
		end
	end

	if unloadRequired then
		P.notify(string.format(
			'Plug "%s" has been loaded but its config function not called. Because its required plugin "%s" is not loaded.',
			plug.id, unloadRequired.repo), 'warn')
	elseif plug.uninstalled then
		P.notify(string.format('Plug "%s" has not installed. Try ":PlugInstall" to install it.', plug.id),
			'warn')
	else
		Plug.mergePlugConfig(CM.config, plug)
		pendings[#pendings + 1] = plug
	end
end

local function setNotify()
	local has_notify, _notify = pcall(require, 'notify')
	local notify

	if has_notify then
		notify = function(msg, level)
			vim.schedule(function()
				_notify(msg, level)
			end)
		end
	else
		notify = print
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

P.Plug = Plug.usePlug

-- @type {function(path)} Load builtin plugin by filepath which relative lua directory.
P.LoadPluginFile = function(path)
	local opts = require('adoyle-neovim-config.' .. path)
	local userPluginOpts = plugMap[opts[1]]
	opts = util.merge(opts, userPluginOpts)
	Plug.usePlug(opts)
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