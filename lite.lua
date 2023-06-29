require('one').setup {
	config = {
		impatient = { enable = false },

		-- headlines = { markdown = { quote_string = false } },

		vim = {
			opt = {
				colorcolumn = { 81, 101 }, -- highlight columns. See ":h 'cc'"
			},
		},

		pluginManager = { use = 'local' }, -- 'vim-plug' or 'packer' or 'lazy' or 'local'

		completion = {
			experimental = {
				ghost_text = { hl_group = 'CmpGhostText' }, -- this feature conflict with copilot.vim's preview.
			},
		},

	},

	---@diagnostic disable-next-line: unused-local
	configFn = require('my.config').configFn,

	onlyPlugins = {
		'vim',
		'one',
		'colors',
		'general.keymap',
		'general.commands',
		'filetype',

		{
			'prichrd/netrw.nvim',
			config = function()
				require'netrw'.setup {
					-- Put your configuration here, or leave the object empty to take the default
					-- configuration.
					icons = {
						symlink = '→', -- Symlink icon (directory and file)
						directory = '', -- Directory icon
						file = '', -- File icon
					},
					use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
					mappings = {}, -- Custom key mappings
				}
			end,
			keymaps = { { '', '<Space>m', ':Lexplore<CR>' } },
		},

		{
			highlights = require('my.highlights'),
			filetypes = require('my.filetypes'),
			commands = require('my.commands'),
			telescopes = require('my.telescopes'),
			autocmds = require('my.autocmds'),
			keymaps = {
				{ 'i', '<C-a>', '<Esc>I', { noremap = true, silent = true } },
				{ 'i', '<C-e>', '<Esc>A', { noremap = true, silent = true } },
				{ 'i', '<C-b>', '<Esc>ha', { noremap = true, silent = true } },
				{ 'i', '<C-f>', '<Esc>la', { noremap = true, silent = true } },
				{ 'i', '<M-b>', '<Esc>bi', { noremap = true, silent = true } },
				{ 'i', '<M-f>', '<Esc>Ea', { noremap = true, silent = true } },
				{ 'i', '<M-d>', '<Esc>dwa', { noremap = true, silent = true } },
				{ 'i', '<C-d>', '<Esc>dla', { noremap = true, silent = true } },
				{ 'i', '<C-w>', '<Esc>bdei', { noremap = true, silent = true } },
				{ 'i', '<C-k>', '<Esc>Da', { noremap = true, silent = true } },
				{ 'i', '<C-u>', '<Esc>dl0i', { noremap = true, silent = true } },
				{ 'i', 'jk', '<Esc>', { noremap = true, silent = true, desc = 'Exit from input mode' } },
			},
		},
	},

	-- Add your plugins or override plugin default options.
	plugins = {},

	-- @param [opts.onlyPlugins] {string[]|nil}
	-- It's useful for debug. Defaults to nil.
	-- If set empty table, all builtin and user-defined plugins are disabled.
	-- If set non-empty table, only these plugins are not disabled.
	-- onlyPlugins = { 'one', 'pl', 'alpha', 'adoyle-h/alpha-nvim', 'session', 'olimorris/persisted.nvim' },
}

vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#282867' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#232323' })
