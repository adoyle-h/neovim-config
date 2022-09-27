local M = { 'stevearc/aerial.nvim', desc = 'Outline - aerial', requires = {} }

local config = require('adoyle-neovim-config.config').config

M.highlights = { { 'AerialLine', { bg = '#3f1f00', bold = true } } }

M.keymaps = {
	{ 'n', '<space>o', ':AerialToggle<CR>', { silent = true, desc = 'Toggle the aerial window' } },
}

M.defaultConfig = {
	'aerial',
	{
		-- Priority list of preferred backends for aerial.
		-- This can be a filetype map (see :help aerial-filetype-map)
		backends = {
			-- "_" will be used as the default if the filetype is not present.
			['_'] = { 'lsp', 'treesitter' },
			markdown = { 'markdown' },
		},

		highlight_on_hover = true,

		default_direction = 'right',

		min_width = 20,

		show_guides = true,

		guides = {
			-- When the child item has a sibling below it
			mid_item = '├─ ',
			-- When the child item is the last in the list
			last_item = '└─ ',
			-- When there are nested child guides to the right
			nested_top = '│ ',
			-- Raw indentation
			whitespace = '  ',
		},

		filter_kind = false,

		-- filter_kind = {
		--   'Array',
		--   'Boolean',
		--   'Class',
		--   'Constant',
		--   'Constructor',
		--   'Enum',
		--   'EnumMember',
		--   'Event',
		--   'Field',
		--   'File',
		--   'Function',
		--   'Interface',
		--   'Key',
		--   'Method',
		--   'Module',
		--   'Namespace',
		--   'Null',
		--   'Number',
		--   'Object',
		--   'Operator',
		--   'Package',
		--   'Property',
		--   'String',
		--   'Struct',
		--   'TypeParameter',
		--   'Variable',
		-- },

		icons = (function()
			local icons = { Interface = config.symbolMap.MID_DOT }
			for k, v in pairs(config.kindSymbolMap) do if icons[k] == nil then icons[k] = v end end
			return icons
		end)(),

		on_attach = function(bufnr)
			require('aerial').tree_set_collapse_level(bufnr, 0)
		end,
	},
}

function M.config()
	require('aerial').setup(config.aerial)
end

return M
