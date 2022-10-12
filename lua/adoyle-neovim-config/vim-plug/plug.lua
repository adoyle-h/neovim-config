local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')
local normalizeOpts = require('adoyle-neovim-config.vim-plug.normalize')
local globals = require('adoyle-neovim-config.vim-plug.globals')
local plugMap, plugs, userPlugins = globals.plugMap, globals.plugs, globals.userPlugins

local fn = vim.fn
local loadPlug = fn['plug#']

-- Vim-Plug Options:
-- branch/tag/commit : Branch/tag/commit of the repository to use
--               rtp : Subdirectory that contains Vim plugin
--               dir : Custom directory for the plugin
--                as : Use different name for the plugin
--   do (alias: run) : Post-update hook (string or funcref)
--   on (alias: cmd) : On-demand loading: Commands or <Plug>-mappings
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

-- The structure of M should be compatible with packer.nvim Plug and vim-plug Plug
-- @param M {string|table} See packer.nvim Plug: https://github.com/wbthomason/packer.nvim#specifying-plugins
-- @param [opts] {table}
-- @useage Plug(repo[, opts])
-- @useage Plug({repo, opts...})
-- The repo is a string. Example: 'nvim-lua/plenary.nvim'
local function usePlug(repo, opts)
	opts = normalizeOpts(repo, opts)
	repo = opts.repo
	local id = opts.id

	local userPluginOpts = userPlugins[id]
	if userPluginOpts then
		opts = util.merge(opts, userPluginOpts) -- For user override existed plugin config
		userPlugins[id] = nil -- Avoid repeat merge userPluginOpts. And for loading user added plugins in P.fin()
	end

	plugMap[id] = opts

	if opts.disable == true then
		-- disable current and required plugs
		return false
	end

	-- Load dependent plugins first, then current plugin
	for _, dep in pairs(opts.requires or {}) do usePlug(dep) end

	table.insert(plugs, opts)
	globals.count = globals.count + 1

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

		-- If plug is uninstalled
		local folderPath = CM.config.pluginManager.pluginDir .. '/' .. getPlugFolderName(repo)
		if not util.exist(folderPath) then opts.uninstalled = true end
	end

end

local function mergePlugConfig(node, plug)
	local defaultConfig = plug.defaultConfig

	if type(defaultConfig) == 'function' then defaultConfig = defaultConfig(CM.config) end

	if defaultConfig then
		if type(defaultConfig) ~= 'table' then
			error(fn.printf('Plug defaultConfig must be a table, but current value is %s. Current Plugin=%s',
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

return { usePlug = usePlug, mergePlugConfig = mergePlugConfig }
