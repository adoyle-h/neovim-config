local M = {
	'stevearc/aerial.nvim',
	desc = 'Outline - aerial',
	disable = false,
	requires = {},
}

function M.config()
	local config = require('adoyle-neovim-config.config').global
	local util = require('adoyle-neovim-config.util')
	local keymap = vim.keymap.set

	keymap('n', '<space>o', '<cmd>AerialToggle<CR>', {
		noremap = true, silent = true, desc = 'Toggle the aerial window',
	})

	local icons = { Interface = config.symbolMap.MID_DOT, }
	for k, v in pairs(config.kindSymbolMap) do
		if icons[k] == nil then
			icons[k] = v
		end
	end

	require('aerial').setup {
		-- Priority list of preferred backends for aerial.
		-- This can be a filetype map (see :help aerial-filetype-map)
		backends = {
			-- "_" will be used as the default if the filetype is not present.
			['_']    = { 'lsp', 'treesitter' },
			markdown = { 'markdown' },
		},

		highlight_on_hover = true,

		default_direction = 'right',

		min_width = 20,

		show_guides = true,

		guides = {
			-- When the child item has a sibling below it
			mid_item = "├─ ",
			-- When the child item is the last in the list
			last_item = "└─ ",
			-- When there are nested child guides to the right
			nested_top = "│ ",
			-- Raw indentation
			whitespace = "  ",
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

		icons = icons,
	}

	util.set_hl {
		{ 'AerialLine', { bg = config.color.outline.lineBG, bold = true } },
	}
end

return M
