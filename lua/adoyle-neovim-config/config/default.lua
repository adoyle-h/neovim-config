-- User should not change this file. Edit require('adoyle-neovim-config').setup({config}) in your init.lua.
return function(colors)
	local symbol = require('adoyle-neovim-config.config.symbol')

	return {
		colors = colors,

		theme = 'onedarkpro',

		pluginManager = {
			-- All plugins are downloaded in this directory
			-- Default: ~/.local/share/nvim/plugins
			pluginDir = vim.fn.stdpath('data') .. '/plugins',
			timeout = 30,
		},

		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/')
			github = '', -- emptry string or proxy url
		},

		ignore = {
			fileSearch = { --
				names = { 'node_modules', '.git', 'vendor' },
			},

			fileTypesForSomePlugs = {
				'TelescopePrompt',
				'TelescopeResults',
				'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
				'lsp-installer',
				'null-ls-info',
				'lspinfo',
				'nerdtree',
				'NvimTree',
				'neo-tree',
				'notify',
				'aerial',
				'Mundo',
				'mason',
				'man',
				'PlenaryTestPopup',
			},
		},

		symbolMap = symbol.symbolMap,

		kindSymbolMap = symbol.kindSymbolMap,

		codeContext = { -- show code context which parsed by treesitter
			winbar = true, -- show context path in winbar
			float = true, -- show context funciton float on top
		},

	}
end
