vim.opt.rtp:prepend('~/.local/share/nvim/plugins/one.nvim')

require('one').setup {
	config = {
		-- headlines = { markdown = { quote_string = false } },

		vim = {
			opt = {
				colorcolumn = { 81, 101 }, -- highlight columns. See ":h 'cc'"
			},
		},

		pluginManager = { use = 'local' }, -- 'vim-plug' or 'packer' or 'lazy' or 'local'

	},

	---@diagnostic disable-next-line: unused-local
	configFn = require('my.config').configFn,

	-- @param [opts.onlyPlugins] {string[]|nil}
	-- It's useful for debug. Defaults to nil.
	-- If set empty table, all builtin and user-defined plugins are disabled.
	-- If set non-empty table, only these plugins are not disabled.
	onlyPlugins = { 'vim', 'one', 'colors', 'general.keymap', 'general.commands', 'filetype', '1', '2' },

	-- Add your plugins or override plugin default options.
	plugins = {

		{
			id = '1',
			highlights = require('my.highlights'),
			filetypes = require('my.filetypes').callbacks,
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

		{
			id = '2',
			highlights = { --
				StatusLine = { fg = '#7B85D6', bg = '#282867' },
				StatusLineNC = { bg = '#232323' },
			},
			keymaps = { { '', '<Space>m', ':Lexplore<CR>', { silent = true } } },
		},

	},
}
