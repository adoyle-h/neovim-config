-- telescope extension tools
local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local sorters = require('adoyle-neovim-config.telescope.sorters')
local previewers = require('adoyle-neovim-config.telescope.previewers')

-- @param ext {table}
--   See telescope.nvim/lua/telescope/pickers.lua Picker:new
--   See https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#picker
-- @param ext.name {string}
-- @param ext.prompt_title {string}
-- @param ext.results_title {string}
-- @param ext.preview_title='Preview' {string}
-- @param ext.finder {Finder}
-- @param ext.sorter {Sorter}
-- @param ext.previewer {previewer}
-- @param ext.attach_mappings {function():boolean}
-- @param ext.layout_strategy {table}
-- @param ext.layout_config {table}
-- @param ext.scroll_strategy {string}
-- @param ext.selection_strategy {string} Values: follow, reset, row
-- @param ext.cwd {string}
-- @param ext.default_text {string}
-- @param ext.default_selection_index {number}
--   Change the index of the initial selection row
local function extCallback(ext, opts)
	local results = {}
	local items = {}

	ext = vim.tbl_extend('keep', ext, {
		prompt_title = ext.name,
		preview_title = 'Preview',
		previewer = false,
		wrap_results = true,
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				local item = items[selection.index]
				if ext.onSubmit then ext.onSubmit(item) end
			end)

			return true
		end,
	})

	local previewer = ext.previewer
	if type(previewer) == 'string' then ext.previewer = previewers.get(previewer) end

	local command = ext.command

	if type(command) == 'function' then
		local r = command()
		for _, item in pairs(r) do --
			local text = item.text
			if #text > 0 then
				table.insert(results, text)
				table.insert(items, item)
			end
		end
	else
		local r = vim.api.nvim_exec(command, true)

		for _, text in pairs(vim.split(r, '\n')) do --
			if #text > 0 then
				table.insert(results, text)
				table.insert(items, { text = text })
			end
		end
	end

	if ext.finder then
		ext.finder = ext.finder { results = results }
	else
		ext.finder = finders.new_table { results = results }
	end

	if ext.default_selection_index == -1 then ext.default_selection_index = #results end

	-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#first-picker
	pickers.new(opts, ext):find()
end

local function register(extension)
	local name = extension.name

	local ext = telescope.register_extension({
		-- function(ext_config, config)
		setup = extension.setup,
		exports = {
			-- Default when to argument is given, i.e. :Telescope changes
			[name] = function(opts)
				extCallback(extension, opts)
			end,
		},
	})

	telescope.extensions[name] = ext.exports
	-- if ext.setup then ext.setup(extensions._config[name] or {}, require('telescope.config').values) end
	-- extensions._health[name] = ext.health
end

return {
	register = register,
	previewers = previewers,
	actions = actions,
	sorters = sorters,
	finders = finders,
}
