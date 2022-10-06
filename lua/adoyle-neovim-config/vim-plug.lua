-- The packer.nvim is terrible. Use vim-plug! https://github.com/junegunn/vim-plug
local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')

local fn = vim.fn
local loadPlug = vim.fn['plug#']
local set_keymap = vim.keymap.set
local set_hl = vim.api.nvim_set_hl
local set_cmd = vim.api.nvim_create_user_command
local sign_define = vim.fn.sign_define

local P = { count = 0, plugs = {}, userPlugins = {}, userPluginConfigs = nil }

local UNLOAD = 'UNLOAD'

-- Vim-Plug Options:
-- branch/tag/commit : Branch/tag/commit of the repository to use
--               rtp : Subdirectory that contains Vim plugin
--               dir : Custom directory for the plugin
--                as : Use different name for the plugin
--                do : Post-update hook (string or funcref)
--                on : On-demand loading: Commands or <Plug>-mappings
--               for : On-demand loading: File types
--            frozen : Do not update unless explicitly specified
local function parseVimPlugOpts(params)
	local opts = {}
	local fields = {
		'branch',
		'tag',
		'commit',
		'rtp',
		'dir',
		'as',
		run = 'do',
		cmd = 'on',
		'for',
		'frozen',
	}
	for k, v in pairs(fields) do
		opts[v] = params[v]
		if type(k) == 'string' then opts[v] = params[k] end
	end

	return opts
end

local function endsWith(str, suffix)
	return str:sub(-#suffix) == suffix
end

local function getPlugFolderName(repo)
	local s = fn.split(repo, '/')
	local name = s[#s]
	if endsWith(name, '.git') then name = name:sub(0, -5) end
	return name
end

local function normalizeOpts(repo, opts)
	local t = type(repo)
	local count = P.count

	if not opts then
		if t == 'string' then
			opts = { id = count, repo = repo }
		elseif t == 'table' then
			opts = repo
			repo = table.remove(opts, 1)

			if type(repo) == 'string' then
				if #repo == 0 then error('Invalid value of repo. Cannot be empty string.') end
			elseif repo ~= nil then
				error('Invalid value of repo. Only nil or "string" can be repo name.')
			end

			opts.id = count
			opts.repo = repo
		else
			error(fn.printf('Invalid Plug Type: %s', t))
		end
	else
		opts.repo = repo
	end

	opts.requires = opts.requires or {}

	return opts
end

-- The structure of M should be compatible with packer.nvim Plug and vim-plug Plug
-- @param M {string|table} See packer.nvim Plug: https://github.com/wbthomason/packer.nvim#specifying-plugins
-- @param [opts] {table}
-- @useage Plug(repo[, opts])
-- @useage Plug({repo, opts...})
-- The repo is a string. Example: 'nvim-lua/plenary.nvim'
local function usePlug(repo, opts)
	opts = normalizeOpts(repo, opts)
	repo = opts.repo

	local userPluginOpts = P.userPlugins[repo]
	if userPluginOpts then
		opts = util.merge(opts, userPluginOpts)
		P.userPlugins[repo] = nil
	end

	if opts.disable == true then
		-- disable current and required plugs
		return false
	end

	P.plugs[repo or opts.id] = opts
	P.count = P.count + 1

	-- Load dependencies first
	for _, dep in pairs(opts.requires) do usePlug(dep) end

	-- Handle current plugin

	-- Run setup before plugin is loaded.
	if opts.setup then opts.setup() end

	if type(repo) == 'string' then
		local plugOpts = parseVimPlugOpts(opts)
		if vim.tbl_isempty(plugOpts) then
			loadPlug(repo)
		else
			loadPlug(repo, plugOpts)
		end

		-- If plug is uninstalled, do not continue
		local foldname = getPlugFolderName(repo)
		if not util.exist(CM.config.pluginManager.pluginDir .. '/' .. foldname) then opts.status = UNLOAD end
	end

end

function P.setup(opts)
	set_keymap('n', '<SPACE>P', '<cmd>:PlugStatus<CR>', { desc = 'Show Plugin Status' })

	vim.g.plug_timeout = CM.config.pluginManager.timeout
	-- Use git proxy for fast downloading
	vim.g.plug_url_format = util.proxyGithub 'https://github.com/%s'

	P.userPluginConfigs = opts.userPluginConfigs

	for _, p in pairs(opts.userPlugins or {}) do
		local plugOpts = normalizeOpts(p)
		P.userPlugins[plugOpts.repo] = plugOpts
	end
end

function P.start()
	vim.call('plug#begin', CM.config.pluginManager.pluginDir)
end

local function propSet(list, func)
	if list then
		if type(list) == 'function' then list = list(CM.config) end

		for _, args in pairs(list) do --
			func(table.unpack(args))
		end
	end
end

local function defaultRedef(args)
	return args
end

local function propSet2(list, func, redef)
	redef = redef or defaultRedef
	if list then
		if type(list) == 'function' then list = list() end

		for _, args in pairs(list) do --
			func(table.unpack(redef(args)))
		end
	end
end

local function mergePlugConfig(node, plug)
	local defaultConfig = plug.defaultConfig

	if type(defaultConfig) == 'function' then defaultConfig = defaultConfig(CM.config) end

	if defaultConfig then
		if type(defaultConfig) ~= 'table' then
			error(vim.fn.printf(
				'Plug defaultConfig must be a table, but current value is %s. Current Plugin=%s',
				vim.inspect(defaultConfig), vim.inspect(plug)))
		end

		local fields = defaultConfig[1]
		if type(fields) == 'string' then fields = { fields } end

		for i, k in pairs(fields) do
			if i < #fields then
				if node[k] == nil then node[k] = {} end
				node = node[k]
			else
				local cur = node[k] or {}
				-- print(vim.inspect(defaultConfig[1]))
				node[k] = vim.tbl_deep_extend('keep', cur, defaultConfig[2])
			end
		end
	end
end
P.mergeConfig = mergePlugConfig

function P.fin()
	for _, p in pairs(P.userPlugins) do if p then usePlug(p) end end

	vim.call('plug#end')
end

function P.run()
	local has_notify, notify = pcall(require, 'notify')
	if not has_notify then notify = print end

	local config = CM.config
	local pendings = {}

	for _, plug in pairs(P.plugs) do
		local unloadRequired = false

		for _, required in pairs(plug.requires) do
			local requiredName
			if type(required) == 'string' then
				requiredName = required
			else
				requiredName = required[1]
			end

			local reqP = P.plugs[requiredName]
			if reqP then
				if reqP.disable then
					unloadRequired = reqP
					break
				end
			end
		end

		if unloadRequired then
			notify(fn.printf(
				'Plug "%s" has been loaded but its config function not called. Because its required plugin "%s" is not loaded.',
				plug.repo, unloadRequired.repo), 'warn')
		else
			mergePlugConfig(config, plug)

			table.insert(pendings, plug)
		end
	end

	if P.userPluginConfigs then
		local userPluginConfigs = P.userPluginConfigs()
		for key, value in pairs(userPluginConfigs) do config[key] = util.merge(config[key], value) end
	end

	for _, plug in pairs(pendings) do
		if type(plug.config) == 'function' then
			local success, msg = pcall(plug.config, config)
			if not success then notify(msg, 'warn') end
		end

		local list = plug.highlights
		if list then
			if type(list) == 'function' then list = list(config) end

			for _, hl in pairs(list) do
				-- if type(hl) == 'function' then hl = hl(color) end
				set_hl(0, hl[1], hl[2])
			end
		end

		propSet(plug.keymaps, set_keymap)
		propSet(plug.commands, set_cmd)
		propSet(plug.signs, sign_define)
	end

	-- notify user
	for _, plug in pairs(P.plugs) do
		if plug.uninstalled then
			notify(fn.printf('Plug "%s" has not installed. Try ":PlugInstall" to install it.',
				plug.repo or plug.id), 'warn')
		end
	end
end

P.Plug = usePlug

-- @type {function(path)} Load builtin plugin by filepath which relative lua directory.
P.LoadPluginFile = function(path)
	local opts = require('adoyle-neovim-config.' .. path)
	local userPluginOpts = P.plugs[opts[1]]
	opts = util.merge(opts, userPluginOpts)
	usePlug(opts)
end

return P
