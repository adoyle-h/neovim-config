local M = { 'stevearc/aerial.nvim', desc = 'Outline - aerial', requires = {} }

local config = require('adoyle-neovim-config.config').config
local keymap = vim.keymap.set

M.highlights = {
	AerialLine = { bg = '#3E1A00' },
	AerialFunction = { fg = '#589CFF' },
	AerialFunctionIcon = { fg = '#589CFF' },
	AerialObject = { fg = '#8DDA00' },
	AerialObjectIcon = { fg = '#8DDA00' },
	AerialArray = { fg = '#1C9A7B' },
	AerialArrayIcon = { fg = '#1C9A7B' },
	AerialVariable = { fg = '#B0B51D' },
	AerialVariableIcon = { fg = '#B0B51D' },
	AerialConstant = { fg = '#F46400' },
	AerialConstantIcon = { fg = '#F46400' },
}

M.keymaps = {
	{ 'n', '<space>o', ':AerialToggle<CR>', { silent = true, desc = 'Toggle the outline window' } },
}

local icons = {}
local Collapsed = config.kindSymbolMap.Collapsed
for key, val in pairs(config.kindSymbolMap) do
	icons[key] = val
	icons[key .. 'Collapsed'] = string.format('%s %s', Collapsed, val)
end

M.defaultConfig = {
	'aerial',
	{
		-- Priority list of preferred backends for aerial.
		-- This can be a filetype map (see :help aerial-filetype-map)
		backends = {
			-- "_" will be used as the default if the filetype is not present.
			['_'] = { 'lsp', 'treesitter', 'markdown' },
			markdown = { 'markdown' },
			man = { 'man' },
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

		filter_kind = {
			['_'] = {
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
		},

		icons = {
			['_'] = icons,

			markdown = vim.tbl_extend('force', icons, { Interface = '', InterfaceCollapsed = Collapsed }),

			help = vim.tbl_extend('force', icons,
				{ Interface = '', InterfaceCollapsed = Collapsed .. ' ' }),

			man = vim.tbl_extend('force', icons,
				{ Interface = '', InterfaceCollapsed = Collapsed .. ' ' }),
		},
	},
}

local function aerialOnOpened(opts)
	local aerial = require('aerial')
	local bufnr = opts.buf
	aerial.tree_set_collapse_level(bufnr, 1)

	keymap('n', '<C-h>', function()
		aerial.up(-1, 1)
	end, { buffer = bufnr })

	keymap('n', '<C-l>', function()
		aerial.up(1, 1)
	end, { buffer = bufnr })
end

function M.config()
	require('aerial').setup(config.aerial)

	vim.api.nvim_create_autocmd('FileType', { pattern = 'aerial', callback = aerialOnOpened })

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

M.autocmds = {
	LspAttach = {
		-- args see https://github.com/neovim/neovim/blob/e6f7e038b8bbca487e78ebfc6fe21d6852330623/runtime/lua/vim/lsp.lua#L1522-L1526
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			require('aerial').on_attach(client, args.buf)
		end,
	},
}

return M
