local M = { 'stevearc/aerial.nvim', desc = 'Outline - aerial', requires = {} }

local config = require('adoyle-neovim-config.config').config

M.highlights = {
	{ 'AerialLine', { bg = '#3E1A00' } },
	{ 'AerialFunction', { fg = '#589CFF' } },
	{ 'AerialFunctionIcon', { fg = '#589CFF' } },
	{ 'AerialObject', { fg = '#8DDA00' } },
	{ 'AerialObjectIcon', { fg = '#8DDA00' } },
	{ 'AerialArray', { fg = '#1C9A7B' } },
	{ 'AerialArrayIcon', { fg = '#1C9A7B' } },
	{ 'AerialVariable', { fg = '#B0B51D' } },
	{ 'AerialVariableIcon', { fg = '#B0B51D' } },
	{ 'AerialConstant', { fg = '#F46400' } },
	{ 'AerialConstantIcon', { fg = '#F46400' } },
}

M.keymaps = {
	{ 'n', '<space>o', ':AerialToggle<CR>', { silent = true, desc = 'Toggle the outline window' } },
}

M.commands = { { 'AerialTelescope', ':Telescope aerial', {} } }

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
		max_width = 50,

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

		-- filter_kind = false,

		filter_kind = {
			'Array',
			'Boolean',
			'Class',
			'Constant',
			'Constructor',
			'Enum',
			'EnumMember',
			'Event',
			'Field',
			'File',
			'Function',
			'Interface',
			'Key',
			'Method',
			'Module',
			'Namespace',
			'Null',
			'Number',
			'Object',
			'Operator',
			-- 'Package', -- @TODO Why "if" condition is a Package kind?
			'Property',
			'String',
			'Struct',
			'TypeParameter',
			'Variable',
		},

		icons = (function()
			local icons = { Interface = config.symbolMap.MID_DOT }
			for k, v in pairs(config.kindSymbolMap) do if icons[k] == nil then icons[k] = v end end
			return icons
		end)(),

		on_attach = function(bufnr)
			require('aerial').tree_set_collapse_level(bufnr, 3)
		end,
	},
}

function M.config()
	require('aerial').setup(config.aerial)

	local has_t, telescope = pcall(require, 'telescope')
	if has_t then
		telescope.setup({
			extensions = {
				aerial = {
					-- Display symbols as <root>.<parent>.<symbol>
					show_nesting = true,
				},
			},
		})
		telescope.load_extension('aerial')
	end
end

return M
