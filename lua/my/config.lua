local M = {}

M.config = {
	proxy = {
		-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
		github = 'https://mirror.ghproxy.com',
	},

	-- pluginManager = { use = 'packer' }, -- 'vim-plug' or 'packer' or 'lazy' or 'local'

	-- colors = require('one.colors.srgb'),

	-- headlines = { markdown = { quote_string = false } },

	vim = {
		opt = {
			colorcolumn = { 81, 101 }, -- highlight columns. See ":h 'cc'"
		},
	},

	lsp = {
		-- log = { level = 'debug' },

		format = {
			-- _ = { on_save = true },

			lua = {
				exclude = { -- exclude is a table of LSP servers that should not format the buffer.
					'sumneko_lua',
				},
			},
		},

		setup = {
			-- clangd = { cmd = { 'clangd', '--enable-config', '--log=verbose' } },
			gopls = {
				settings = {
					gopls = {
						env = { --
							GOFLAGS = '-tags=linux,darwin,test,unittest', -- I don't care windows
						},
					},
				},
			},
		},
	},

	-- theme = { use = 'tokyonight' },
	-- theme = { use = 'catppuccin' },
	-- theme = { use = 'nightfox' },

	-- pluginManager = { use = 'vim-plug' }, -- 'vim-plug' or 'packer' or 'lazy'

	translate = {
		targetLang = 'zh-CN', -- 'en', 'zh-CN', 'zh-TW'. See the completion list when typing `:Translate `.
		default = { command = 'translate_shell' },
	},

	completion = {
		experimental = {
			ghost_text = { hl_group = 'CmpGhostText' }, -- this feature conflict with copilot.vim's preview.
		},
	},

	noice = {
		-- routes = { --- @see section on routes
		-- 	-- { filter = { event = 'msg_show', kind = '', find = '^<' }, opts = { skip = true } },
		-- },
	},
}

M.configFn = function()
	-- This user config will override default config. Below config is an example just for my personal usage.
	return {
		treesitter = require('my.treesitter'),
		nullLS = require('my.null-ls')(),
		['mason-installer'] = require('my.mason'),
		filetype = require('my.filetypes').ft,
	}
end

return M
