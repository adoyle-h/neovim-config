-- User should not change this file. Edit require('adoyle-neovim-config').setup({config}) in your init.lua.
return function(color)
	local symbol = require('adoyle-neovim-config.config.symbol')

	return {
		color = color,

		highlights = require('adoyle-neovim-config.config.highlight-group')(color),

		vim = require('adoyle-neovim-config.config.vim-options'),

		theme = 'onedarkpro',

		-- All plugins are downloaded in this directory
		-- Default: ~/.local/share/nvim/plugins
		pluginDir = vim.fn.stdpath('data') .. '/plugins',

		pluginOpts = { -- Override plugin default config
			-- ['plugins.profiling'] = {
			--   disable = false, -- Set false to enable the disabled plugin by default.
			-- },
		},

		-- Add your plugins. More examples at ./lua/adoyle-neovim-config/plugins.lua
		plugins = {
			-- { 'psliwka/vim-smoothie', disable = false },

			-- function(Plug)
			--   Plug { 'psliwka/vim-smoothie', disable = false }
			-- end,
		},

		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/')
			github = '', -- emptry string or proxy url
		},

		ignore = {
			fileSearch = { names = { 'node_modules', '.git', 'vendor' } },

			fileTypesForSomePlugs = {
				'TelescopePrompt',
				'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
				'lsp-installer',
				'null-ls-info',
				'lspinfo',
				'nerdtree',
				'aerial',
				'Mundo',
				'mason',
				'man',
			},
		},

		symbolMap = symbol.symbolMap,

		kindSymbolMap = symbol.kindSymbolMap,

		codeContext = { -- show code context which parsed by treesitter
			winbar = true, -- show context path in winbar
			float = true, -- show context funciton float on top
		},

		snippets = {
			-- :h snippy
			scopes = {
				-- Because nvim-snippy will merge all snippets into a map which like {'snippet_title' = 'snippet_body'}
				-- Higher priority will override the lower. See ":h snippy-usage-priority"
				-- https://github.com/dcampos/nvim-snippy/blob/1860215584d4835d87f75896f07007b3b3c06df4/lua/snippy/util.lua#L44-L58
				sh = { '_', 'sh' }, -- Load _.snippets and sh.snippets for "sh" filetype
			},
		},
	}
end
