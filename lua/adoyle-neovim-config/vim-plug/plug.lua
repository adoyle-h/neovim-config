local M = {}

local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')

local normalizeOpts = require('adoyle-neovim-config.vim-plug.normalize')
local globals = require('adoyle-neovim-config.vim-plug.globals')
local plugMap, plugs, userPlugins = globals.plugMap, globals.plugs, globals.userPlugins

local fn = vim.fn
local loadPlug = fn['plug#']
local set_keymap = vim.keymap.set
local set_hl = vim.api.nvim_set_hl
local set_cmd = vim.api.nvim_create_user_command
local sign_define = vim.fn.sign_define

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
function M.usePlug(repo, opts)
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
	for _, dep in pairs(opts.requires or {}) do M.usePlug(dep) end

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

function M.mergePlugConfig(node, plug)
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

local function handlePlugOptions(list, opt)
	if type(list) == 'function' then list = list(CM.config) end

	if opt.iterator then
		for _, args in pairs(list or {}) do --
			if opt.unpack then
				opt.iterator(table.unpack(args))
			else
				opt.iterator(args)
			end
		end
	end
end

local plugOpts = {
	{ name = 'config' },

	{ name = 'signs', iterator = sign_define, unpack = true },

	{ name = 'keymaps', iterator = set_keymap, unpack = true },

	{
		name = 'commands',
		iterator = function(name, command, opts)
			set_cmd(name, command, opts or {})
		end,
		unpack = true,
	},

	{
		name = 'highlights',
		iterator = function(name, props)
			set_hl(0, name, props)
		end,
		unpack = true,
	},

	{
		name = 'telescopes',
		iterator = function(opts)
			local extTools = require('adoyle-neovim-config.plugins.telescope.extension-tools')
			extTools.register(opts)
		end,
		unpack = false,
	},
}
M.plugOpts = plugOpts

function M.executePlugOptions(plug)
	for _, opt in pairs(plugOpts) do --
		handlePlugOptions(plug[opt.name], opt)
	end
end

return M
