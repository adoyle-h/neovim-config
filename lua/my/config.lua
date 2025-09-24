local M = {}

-- This user config will override default config. Below config is an example just for my personal usage.

M.config = {
	proxy = {
		-- If you are in China Mainland, it is suggested to set github proxy. Otherwise, remove this option.
		-- See https://ghproxy.link/
		github = 'https://ghfast.top/',
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

		setup = {
			ts_ls = {
				handlers = {
					['textDocument/publishDiagnostics'] = function() end,
					['textDocument/diagnostic'] = function() end,
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

	smartcolumn = {
		colorcolumn = { 81, 101 },
	},
}

M.config = vim.tbl_deep_extend('force', M.config, require('my.ai').config)

local function setEnvForAvante()
	vim.fn.setenv('OPENAI_API_KEY', vim.fn.getenv('AVANTE_OPENAI_API_KEY'))
	vim.fn.setenv('BRAVE_API_KEY', vim.fn.getenv('AVANTE_BRAVE_API_KEY'))
end

M.configFn = function(config)
	setEnvForAvante()

	return {
		treesitter = require('my.treesitter'),
		noneLS = require('my.null-ls').config(config),
		statusline = require('my.lualine').config(config),
		['mason-installer'] = require('my.mason'),
		filetype = require('my.filetypes').ft,
	}
end

return M
