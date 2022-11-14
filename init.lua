require('one').setup {
	config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
			github = 'https://ghproxy.com',
		},

		global = 'a',

		-- pluginManager = { use = 'packer' }, -- 'vim-plug' or 'packer'

		completion = {
			experimental = {
				ghost_text = { hl_group = 'CmpGhostText' }, -- this feature conflict with copilot.vim's preview.
			},
		},
	},

	---@diagnostic disable-next-line: unused-local
	configFn = function(config)
		-- This user config will override default config. Below config is an example just for my personal usage.
		return {
			vim = {
				opt = {
					colorcolumn = { 81, 101 }, -- highlight columns. See ":h 'cc'"
				},
			},

			treesitter = require('my.treesitter'),
			nullLS = require('my.null-ls')(),
			['mason-installer'] = require('my.mason'),
		}
	end,

	-- Add your plugins or override plugin default options.
	plugins = require('my.plugins'),

	-- @param [opts.onlyPlugins] {string[]|nil}
	-- It's useful for debug. Defaults to nil.
	-- If set empty table, all builtin and user-defined plugins are disabled.
	-- If set non-empty table, only these plugins are not disabled.
	-- onlyPlugins = { 'alpha', 'adoyle-h/alpha-nvim' },
}
