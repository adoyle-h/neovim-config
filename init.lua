require('one').setup {
	config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
			github = 'https://ghproxy.com',
		},

		-- headlines = { markdown = { quote_string = false } },

		lsp = {
			format = {
				-- _ = { on_save = true },

				lua = {
					exclude = { -- exclude is a table of LSP servers that should not format the buffer.
						'sumneko_lua',
					},
				},
			},
		},

		-- theme = { use = 'tokyonight' },
		-- theme = { use = 'catppuccin' },
		-- theme = { use = 'nightfox' },

		-- pluginManager = { use = 'vim-plug' }, -- 'vim-plug' or 'packer' or 'lazy'

		global = 'a',

		translate = {
			targetLang = 'zh-CN', -- 'en', 'zh-CN', 'zh-TW'. See the completion list when typing `:Translate `.
			default = { command = 'translate_shell' },
		},

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
	-- onlyPlugins = { 'one', 'pl', 'alpha', 'adoyle-h/alpha-nvim', 'session', 'olimorris/persisted.nvim' },
}
