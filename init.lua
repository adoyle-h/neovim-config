require('one').setup {
	config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
			github = 'https://ghproxy.com',
		},

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

		-- theme = { use = false },

		-- pluginManager = { use = 'packer' }, -- 'vim-plug' or 'packer'

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
	-- onlyPlugins = { 'alpha', 'adoyle-h/alpha-nvim' },
}
