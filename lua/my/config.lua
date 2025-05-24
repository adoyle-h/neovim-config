local M = {}

-- This user config will override default config. Below config is an example just for my personal usage.

M.config = {
	proxy = {
		-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
		github = 'https://gh-proxy.com',
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

	avante = {
		provider = 'openai',
		openai = {
			endpoint = 'https://api.vveai.com/v1',
			model = 'gpt-4o-mini', -- your desired model (or use gpt-4o, etc.)
			timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			temperature = 0,
			max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
			--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
		},
	},
}

function setEnvForAvante()
	vim.fn.setenv('OPENAI_API_KEY', vim.fn.getenv('AVANTE_OPENAI_API_KEY'))
end

M.configFn = function()
	setEnvForAvante()

	return {
		treesitter = require('my.treesitter'),
		noneLS = require('my.null-ls').config(),
		statusline = require('my.lualine').config(),
		['mason-installer'] = require('my.mason'),
		filetype = require('my.filetypes').ft,
	}
end

return M
