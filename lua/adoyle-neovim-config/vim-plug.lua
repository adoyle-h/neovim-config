-- The packer.nvim is terrible. Use vim-plug! https://github.com/junegunn/vim-plug
local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')

local fn = vim.fn
local loadPlug = vim.fn['plug#']
local set_keymap = vim.keymap.set
local set_hl = vim.api.nvim_set_hl
local set_cmd = vim.api.nvim_create_user_command
local sign_define = vim.fn.sign_define

local plugOptsKeys = { cmd = 'on', run = 'do' }

local P = { pluginDir = nil, plugs = {}, loadPlugs = {}, unloadRepos = {} }

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
local function parsePlugOpts(plugin)
	local opts = util.merge({}, plugin)

	for alias, key in pairs(plugOptsKeys) do if plugin[alias] ~= nil then opts[key] = plugin[alias] end end

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

-- The structure of M should be compatible with packer.nvim Plug and vim-plug Plug
-- @param M {string|table} See packer.nvim Plug: https://github.com/wbthomason/packer.nvim#specifying-plugins
-- @param [opts] {table}
-- @useage Plug(repo[, opts])
-- @useage Plug({repo, opts...})
-- The repo is a string. Example: 'nvim-lua/plenary.nvim'
local function usePlug(repo, opts)
	local t = type(repo)

	if not opts then
		if t == 'string' then
			loadPlug(repo)
			opts = { id = #P.plugs }
		elseif t == 'table' then
			opts = repo
			repo = table.remove(opts, 1)

			if repo == nil then
				repo = #P.plugs
			elseif type(repo) ~= 'string' then
				error('Invalid value of repo. Only nil or "string" can be repo name.')
			elseif #repo == 0 then
				error('Invalid value of repo. Cannot be empty string.')
			end

			opts.id = #P.plugs
			opts.repo = repo
		else
			error(fn.printf('Invalid Plug Type: %s', t))
		end
	end

	local userPluginOpts = CM.config.pluginOpts[repo]
	opts = util.merge(opts, userPluginOpts)

	table.insert(P.plugs, opts)
	CM.config.pluginOpts[repo] = opts

	if opts.disable == true then
		-- disbale current and required plugs
		return
	end

	-- load dependencies first
	if opts.requires then for _, dep in pairs(opts.requires) do usePlug(dep) end end

	-- handle current plugin
	local plugOpts = parsePlugOpts(opts)
	plugOpts.repo = repo

	if plugOpts.setup then
		-- Run setup before plugin is loaded.
		plugOpts.setup()
	end

	if type(repo) == 'string' then
		if #plugOpts > 0 then
			loadPlug(repo, plugOpts)
		else
			loadPlug(repo)
		end

		-- If plug is uninstalled, do not continue
		local foldname = getPlugFolderName(repo)
		if not util.exist(P.pluginDir .. '/' .. foldname) then
			plugOpts.status = UNLOAD
			P.unloadRepos[repo] = plugOpts
			return
		end

		table.insert(P.loadPlugs, plugOpts)
	else
		-- repo equals number
		table.insert(P.loadPlugs, plugOpts)
	end
end

function P.setup()
	set_keymap('n', '<SPACE>P', '<cmd>:PlugStatus<CR>', { desc = 'Show Plugin Status' })

	vim.g.plug_timeout = 30
	-- Use git proxy for fast downloading
	vim.g.plug_url_format = util.proxyGithub 'https://github.com/%s'

	P.pluginDir = CM.config.pluginDir
end

function P.start()
	vim.call('plug#begin', P.pluginDir)
end

local function propSet(list, func)
	if list then
		if type(list) == 'function' then list = list() end

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

local function mergeConfig(node, plugDefaultConfig)
	if type(plugDefaultConfig) == 'function' then plugDefaultConfig = plugDefaultConfig() end

	if plugDefaultConfig then
		local fields = plugDefaultConfig[1]
		if type(fields) == 'string' then fields = { fields } end

		for i, k in pairs(fields) do
			if i < #fields then
				if node[k] == nil then node[k] = {} end
				node = node[k]
			else
				local merged = node[k] or {}
				-- print(vim.inspect(plugDefaultConfig[1]))
				for key, value in pairs(plugDefaultConfig[2]) do merged[key] = value end
				node[k] = merged
			end
		end
	end
end
P.mergeConfig = mergeConfig

function P.fin()
	vim.call('plug#end')

	local has_notify, notify = pcall(require, 'notify')
	if not has_notify then notify = print end

	local color = CM.config.color

	for _, M in pairs(P.loadPlugs) do
		local unloadRequired = false
		for _, requiredName in pairs(M.requires or {}) do
			M2 = P.unloadRepos[requiredName]
			if M2 then
				unloadRequired = M2
				break
			end
		end

		if unloadRequired then
			notify(fn.printf(
				'Plug "%s" has been loaded but its config function not called. Because its required plugin "%s" is not loaded.',
				M.repo, unloadRequired.repo), 'warn')
		else
			mergeConfig(CM.config, M.defaultConfig)

			if type(M.config) == 'function' then M.config() end

			local list = M.highlights
			if list then
				if type(list) == 'function' then list = list(color) end

				for _, hl in pairs(list) do
					-- if type(hl) == 'function' then hl = hl(color) end
					set_hl(0, hl[1], hl[2])
				end
			end

			propSet(M.keymaps, set_keymap)
			propSet(M.commands, set_cmd)
			propSet(M.signs, sign_define)
		end
	end

	for repo in pairs(P.unloadRepos) do
		notify(fn.printf('Plug "%s" has not installed. Try ":PlugInstall" to install it.', repo), 'warn')
	end
end

P.Plug = usePlug

vim.api.nvim_create_user_command('ListPlugs', function()
	vim.notify(vim.inspect(P.loadPlugs))
end, {})

return P
