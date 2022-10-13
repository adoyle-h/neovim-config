local telescope = require('telescope')
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local telescopeConf = require('telescope.config').values
local previewers = require('adoyle-neovim-config.plugins.telescope.extension-tools.previewers')
local actions = require('adoyle-neovim-config.plugins.telescope.extension-tools.actions')

local function extCallback(ext, opts)
	local name = ext.name
	local command = ext.command or ''
	local previewer = ext.previewer or {}
	local action = ext.action or function()
		return true
	end

	local result
	if type(command) == 'function' then
		result = command()
	else
		result = vim.api.nvim_exec(command, true)
	end

	-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#first-picker
	local selections = pickers.new(opts, {
		prompt_title = 'Command: ' .. name,
		finder = finders.new_table { results = vim.split(result, '\n', { trimempty = true }) },
		sorter = telescopeConf.generic_sorter(opts),
		previewer = previewer,
		attach_mappings = action,
	}):find()

	if ext.onSubmit then ext.onSubmit(selections) end
end

local function register(extensions)
	for _, ext in ipairs(extensions) do
		local name = ext.name

		local e = telescope.register_extension({
			-- function(ext_config, config)
			setup = ext.setup,
			exports = {
				-- Default when to argument is given, i.e. :Telescope changes
				[name] = function(opts)
					extCallback(ext, opts)
				end,
			},
		})

		telescope.extensions[name] = e.exports
		-- if ext.setup then ext.setup(extensions._config[name] or {}, require('telescope.config').values) end
		-- extensions._health[name] = ext.health
	end
end

return { register = register, previewers = previewers, actions = actions }
