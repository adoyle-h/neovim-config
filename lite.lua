require('one').setup {
	config = {
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

	onlyPlugins = { 'vim', 'one', 'colors', 'general.keymap', 'general.commands', 'filetype' },

	-- Add your plugins or override plugin default options.
	plugins = {

		{
			disable = false,
			config = function()
				require('netrw').setup {
					-- Put your configuration here, or leave the object empty to take the default configuration.
					icons = {
						symlink = '→', -- Symlink icon (directory and file)
						directory = '', -- Directory icon
						file = '󰈙', -- File icon
						['.gitattributes'] = { icon = '', color = '#FA4F28', name = 'GitAttributes' },
						['.gitconfig'] = { icon = '', color = '#FA4F28', name = 'GitConfig' },
						['.gitignore'] = { icon = '', color = '#FA4F28', name = 'GitIgnore' },
						['.gitlab-ci.yml'] = { icon = '', color = '#FC6D26', name = 'GitlabCI' },
						['.gitmodules'] = { icon = '', color = '#FA4F28', name = 'GitModules' },
						['.lua-format'] = { icon = '', color = '#28A2D4', name = 'LuaFormatter' },
						['.editorconfig'] = { icon = '', color = '#BEC0C4', name = 'EditorConfig' },
						['.eslintrc.yml'] = { icon = '', color = '#8080F2', name = 'EslintRC' },
						['.prettierignore'] = { icon = '', color = '#C794C8', name = 'PrettierIgnore' },
						['svg'] = { icon = '', color = '#BEC0C4', name = 'Svg' },
					},
					use_devicons = false, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
					mappings = {}, -- Custom key mappings
				}
			end,
			keymaps = { { '', '<Space>m', ':Lexplore<CR>' } },
		},

		{
			disable = false,
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

	-- @param [opts.onlyPlugins] {string[]|nil}
	-- It's useful for debug. Defaults to nil.
	-- If set empty table, all builtin and user-defined plugins are disabled.
	-- If set non-empty table, only these plugins are not disabled.
	-- onlyPlugins = { 'one', 'pl', 'alpha', 'adoyle-h/alpha-nvim', 'session', 'olimorris/persisted.nvim' },
}

vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#282867' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#232323' })
