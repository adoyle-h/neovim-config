local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')
local N = require('adoyle-neovim-config.plugin-manager.normalize')
local Plug = require('adoyle-neovim-config.plugin-manager.plug')
local usePlug = require('adoyle-neovim-config.plugin-manager.use-plug')

local notify = util.notify

local PM = { --
	plugs = {},
	plugMap = {},
	userPlugins = {},
	configFn = nil,
	P = nil,
	index = 0,
}

N.PM = PM
local normalizeOpts = N.normalizeOpts
local executePlugOptions = Plug.executePlugOptions

-- Load Plug
-- @useage Plug(repo[, opts])
-- @useage Plug({repo, opts...})
--
-- @param repo {string}
--   repo='<github-user>/<repo-name>' such as 'nvim-lua/plenary.nvim', or
--   repo='name' without '/'
-- @param opts {table} Its fields are compatible with https://github.com/junegunn/vim-plug#plug-options
--
-- @example See examples at ./lua/adoyle-neovim-config/plugins.lua
function PM.Plug(repo, opts)
	local ok, reason = xpcall(usePlug, debug.traceback, PM, PM.P.loadPlug, repo, opts)

	if not ok then
		if type(repo) == 'string' then
			notify(string.format('Failed to load plug "%s". Reason: %s', repo, reason), 'error')
		else
			notify(string.format('Failed to load plug "%s". Reason: %s', opts[1], reason), 'error')
		end
	end
end

-- @param path {string} Load builtin plugin
function PM.LoadBuiltinPlug(path)
	local opts = require('adoyle-neovim-config.plugins.' .. path)
	PM.Plug(opts)
end

function PM.isPlugDisabled(id)
	local p = PM.plugMap[id]
	if p then
		return p.disable
	else
		return true
	end
end

local function addPending(pendings, plug)
	if plug.disable then
		if plug.uninstalled then
			notify(string.format('Plug "%s" has not installed. Try "%s" to install it.', plug.id,
				PM.P.cmds.install), 'warn')
		elseif plug.reason then
			notify(
				string.format('Plug "%s" has been loaded but not setup. Reason: %s', plug.id, plug.reason),
				'warn')
		end
	else
		Plug.mergePlugDefaultConfig(CM.config, plug)
		pendings[#pendings + 1] = plug
	end
end

local function getPlugFolderName(repo)
	local s = vim.fn.split(repo, '/')
	local name = s[#s]
	if vim.endswith(name, '.git') then name = name:sub(0, -5) end
	return name
end

local function isPlugDownloaded(repo)
	local folderPath = PM.P.getPluginFolderPath(getPlugFolderName(repo))

	return util.exist(folderPath)
end

function PM.run(isNew)
	local config = CM.config
	local pendings = {}

	for _, plug in pairs(PM.plugs) do
		if type(plug.repo) == 'string' then
			if not isPlugDownloaded(plug.repo) then
				if plug.disable ~= true then
					plug.disable = true
					plug.reason = 'uninstalled'
					plug.uninstalled = true
				end
			end
		end

		local ok, msg = xpcall(addPending, debug.traceback, pendings, plug)
		if not ok then
			notify(string.format('[Plug: %s] Failed to addPending. Reason: %s', plug.id, msg), 'error')
		end
	end

	if PM.configFn then
		local userConfig = PM.configFn(config) or {}
		for key, value in pairs(userConfig) do config[key] = util.merge(config[key], value) end
	end

	for _, plug in pairs(pendings) do
		local ok, msg = xpcall(executePlugOptions, debug.traceback, plug, config)
		if not ok then
			notify(string.format('[Plug: %s] Failed to executePlugOptions. Reason: %s', plug.id, msg),
				'error')
		end
	end
end

function PM.setP(P)
	PM.P = P
end

function PM.setup(opts)
	local config = CM.config
	local conf = config.pluginManager
	local use = conf.use

	PM.configFn = opts.configFn
	PM.onlyPlugins = opts.onlyPlugins

	if PM.onlyPlugins and vim.tbl_isempty(PM.onlyPlugins) then return end

	local userPlugins = PM.userPlugins
	local userPluginList = {}

	for i, p in pairs(opts.plugins or {}) do
		local ok, plugOpts = pcall(normalizeOpts, p)
		if not ok then
			notify(string.format('Invalid user plugin at index %s. Reason: %s', i, plugOpts), 'error')
		end

		userPlugins[plugOpts.id] = plugOpts
		userPluginList[#userPluginList + 1] = plugOpts -- For keeping plugins order
	end

	local P
	if use == 'vim-plug' then
		P = require('adoyle-neovim-config.plugin-manager.vim-plug')
	elseif use == 'packer' then
		P = require('adoyle-neovim-config.plugin-manager.packer')
	else
		error(string.format('Invalid value of config.pluginManager.use = %s', use))
	end

	PM.setP(P)

	P.setup {
		config = config,

		run = PM.run,

		loadPlugs = function()
			require('adoyle-neovim-config.plugins')(PM.Plug, PM.LoadBuiltinPlug, config)

			for _, p in pairs(userPluginList) do
				if userPlugins[p.id] then
					-- Append user plugins. More examples at ./lua/adoyle-neovim-config/plugins.lua
					PM.Plug(p)
				end
			end
		end,
	}
end

function PM.clean()
	PM.index = 0
	PM.plugs = {}
	PM.plugMap = {}
	PM.userPlugins = {}
end

function PM.isDisabled(id)
	local plug = PM.plugMap[id]
	if not plug then return true end
	return plug.disable
end

return PM
